# Load necessary libraries
library(shiny)
library(janitor)

# Define the UI
ui <- fluidPage(
  titlePanel("DOCC: Disattentuation of Correlations and Cohen's d"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("effectType", 
                  "Select Effect Size Type:", 
                  choices = c("Pearson's r correlation", "Cohen's d standardized mean difference")),
      
      # inputs for cohens d
      conditionalPanel(
        condition = "input.effectType == 'Cohen\\'s d standardized mean difference'",
        numericInput("effectSize", 
                     "Effect Size (d)", 
                     value = .40, 
                     step = 0.1, 
                     min = 0, 
                     max = 1)
      ),
      
      conditionalPanel(
        condition = "input.effectType == 'Cohen\\'s d standardized mean difference'",
        numericInput("reliability1", 
                     "Reliability of the Outcome Measure:", 
                     value = .70, 
                     step = 0.1, 
                     min = 0, 
                     max = 1)
      ),
      
      # inputs for correlations
      conditionalPanel(
        condition = "input.effectType == 'Pearson\\'s r correlation'",
        numericInput("effectSize", 
                     "Correlation (r_xy):", 
                     value = .20, 
                     step = 0.1, 
                     min = 0, 
                     max = 1)
      ),
      
      conditionalPanel(
        condition = "input.effectType == 'Pearson\\'s r correlation'",
        numericInput("reliability1", 
                     "Reliability of Measure 1 (r_xx):", 
                     value = .70, 
                     step = 0.1, 
                     min = 0, 
                     max = 1)
      ),
      
      conditionalPanel(
        condition = "input.effectType == 'Pearson\\'s r correlation'",
        numericInput("reliability2", 
                     "Reliability of Measure 2 (r_yy):", 
                     value = .70, 
                     step = 0.1, 
                     min = 0, 
                     max = 1)
      ),
      
      actionButton("calculate", "Calculate Disattenuated Effect Size")
    ),
    
    mainPanel(
      h3("Results"),
      tableOutput("result")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  observeEvent(input$calculate, {
    # Check if the inputs are valid
    if (is.na(input$effectSize) || is.na(input$reliability1) || 
        (input$effectType == "Pearson's r correlation" && is.na(input$reliability2))) {
      output$result <- renderTable(data.frame(Error = "Please fill in all required inputs."))
      return()
    }
    
    # Calculate the disattenuated effect size
    if (input$effectType == "Pearson's r correlation") {
      r <- input$effectSize
      reliability1 <- input$reliability1
      reliability2 <- input$reliability2
      disattenuated_r <- r / sqrt(reliability1 * reliability2)
      
      result <- ifelse(disattenuated_r < -1 | disattenuated_r > 1, "Inconsistent", "Consistent")
      
      output$result <- renderTable(
        data.frame(
          #type = "Pearson's r",
          reliability_xx = reliability1,
          reliability_yy = reliability2,
          correlation_xy = r,
          disattenuated_correlation_xy = round_half_up(disattenuated_r, 3),
          consistency_with_bounding = result
        )
      )
      
    } else if (input$effectType == "Cohen's d standardized mean difference") {
      d <- input$effectSize
      reliability1 <- input$reliability1
      # Disattenuate Cohen's d directly
      disattenuated_d <- d / sqrt(reliability1)
      
      output$result <- renderTable(
        data.frame(
          #type = "Cohen's d",
          reliability = reliability1,
          effect_size = d,
          disattenuated_effect_size = round_half_up(disattenuated_d, 3)
        )
      )
    }
  })
}

# Run the app
shinyApp(ui = ui, server = server)
