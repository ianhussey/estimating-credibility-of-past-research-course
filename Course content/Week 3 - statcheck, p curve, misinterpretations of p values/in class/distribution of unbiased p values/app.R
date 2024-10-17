# Install necessary packages if not already installed
if (!require(shiny)) install.packages("shiny")
if (!require(ggplot2)) install.packages("ggplot2")

# Load necessary libraries
library(shiny)
library(ggplot2)

# UI for the Shiny app
ui <- fluidPage(
  
  # App title
  titlePanel("What is the distribution of unbiased p-values?"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      # Numeric input for population Cohen's d with a default of 0
      numericInput(
        inputId = "cohens_d",
        label = "Population (true) effect size between the intervention and control group:",
        value = 0,   # default value
        min = -5,    # minimum value
        max = 5,     # maximum value
        step = 0.1   # step size
      ),
      
      # Numeric input for sample size per group
      numericInput(
        inputId = "n_per_group",
        label = "Sample size per group:",
        value = 30,   # default value
        min = 2,      # minimum value
        step = 1      # step size
      ),
      
      # Numeric input for the number of simulated datasets
      numericInput(
        inputId = "num_simulations",
        label = "Number of simulated datasets:",
        value = 20000,  # default value
        min = 1000,     # minimum value
        step = 1000     # step size
      ),
      
      # Checkbox input for zooming in on p-values between 0 and 0.05
      checkboxInput(
        inputId = "zoom_in",
        label = "Zoom in on p-values between 0 and 0.05",
        value = FALSE   # default is unchecked
      ),
      
      # Action button to generate data and run the simulation
      actionButton(inputId = "run", label = "Run Simulation")
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      # Display ggplot histogram
      plotOutput(outputId = "pvalue_histogram"),
      
      # Text output for reporting the percentage of significant p-values
      textOutput(outputId = "significant_percent")
    )
  )
)

# Server logic for the Shiny app
server <- function(input, output) {
  
  # Function to generate simulated data and p-values
  simulate_pvalues <- reactive({
    # Wait until the action button is pressed
    input$run
    
    # Isolate to prevent automatic reactivity without button press
    isolate({
      # Parameters
      cohens_d <- input$cohens_d
      n_per_group <- input$n_per_group  # Get sample size from user input
      num_simulations <- input$num_simulations  # Get the number of simulations from user input
      
      # Initialize a vector to store p-values
      p_values <- numeric(num_simulations)
      
      for (i in 1:num_simulations) {
        # Simulate data for each group
        group1 <- rnorm(n_per_group, mean = 0, sd = 1)
        group2 <- rnorm(n_per_group, mean = cohens_d, sd = 1)
        
        # Perform t-test
        t_test <- t.test(group1, group2, var.equal = TRUE)
        
        # Store the p-value
        p_values[i] <- t_test$p.value
      }
      
      return(p_values)
    })
  })
  
  # Render the histogram plot
  output$pvalue_histogram <- renderPlot({
    # Get the simulated p-values
    p_values <- simulate_pvalues()
    
    # Check if zooming in is selected
    if (input$zoom_in) {
      # Zoom in on p-values between 0 and 0.05
      ggplot(data = data.frame(p_values), aes(x = p_values)) +
        geom_histogram(binwidth = 0.01, boundary = 0, color = "grey25", fill = "#008080") +
        labs(title = "Zoomed in on p-values between 0 and 0.05",
             x = "p-value",
             y = "Frequency") +
        theme_linedraw() + 
        geom_vline(xintercept = 0.05, linetype = "solid", color = "darkred", size = 2) +
        scale_x_continuous(limits = c(0, 0.05))
    } else {
      # Full p-value range
      ggplot(data = data.frame(p_values), aes(x = p_values)) +
        geom_histogram(binwidth = 0.01, boundary = 0, color = "grey25", fill = "#008080") +
        labs(title = paste0("Distribution of p-values for an independent Students' t-test using ", input$num_simulations, " simulated data sets"),
             x = "p-value",
             y = "Frequency") +
        theme_linedraw() + 
        geom_vline(xintercept = 0.05, linetype = "solid", color = "darkred", size = 2) +
        scale_x_continuous(labels = c(0, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0),
                           breaks = c(0, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0),
                           limits = c(0,1)) 
    }
  })
  
  # Calculate and display the percentage of significant p-values (p < 0.05)
  output$significant_percent <- renderText({
    p_values <- simulate_pvalues()
    percent_significant <- mean(p_values < 0.05) * 100
    paste0("Percentage of p-values that are statistically significant (p < 0.05): ", round(percent_significant, 1), "%")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
