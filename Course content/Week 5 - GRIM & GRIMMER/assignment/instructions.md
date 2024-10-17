# Assignment to be completed before we meet on week 6: Apply GRIM and GRIMMER 



## Extract summary statistics for GRIM & GRIMMER

Open each article you've been assigned and search it for suitable summary statistics. Specifically:

- Sets of Mean, N_participants, and N_items for GRIM
- Note that GRIM can also use proportions instead of means, i.e., Proportion, N_participants, and N_items for GRIM
- Sets of SD, N_participants, and N_items for GRIMMER. 

Be very careful not to extract what is labelled as a Standard Error (SE) as if it is a Standard Deviation (SD)!

Good candidates for these summary statistics are:

- Demographics data. Mean and SD of participants age is commonly reported.
- Outcome variables that are self-report scales, particularly short scales, especially single item Likert scales.

Record your extracted values in the "summary_statistics.csv" file that I provided you with. 

- This can be opened in Excel or similar programs. 
- **Make sure you use the same DOI as you have in previous weeks** 
  - **For example, some of you write "https://doi.org/10.1177/0956797609357718" and others write "DOI: 10.1177/0956797609357750". You exactly what you have before, or it will be a pain in my ass to match up your articles across weeks later on.**
  - Last week sheet, which you can copy-paste DOIs from: https://docs.google.com/spreadsheets/d/1VgkYtW6l-QAJK26s9WYXDVYlOPl2XPzl6IQnxCxfERI/edit?gid=0#gid=0
- Use the description column to describe what each row of values refers to, as in the example file.
- Make sure that you do not convert it to another file type, e.g., .xlsx, as the web app for GRIM/GRIMMER needs a .csv file. 
- If your article reports a very large number of suitable summary statistics and you have extracted only some of them, please mention this in the notes column.
- If your article does not report any suitable summary statistics, fill out the DOI column and mention in the notes column that no suitable summary statistics were reported.
- Please double check all your extractions for errors. It is as easy for you to make a typo as it is the original authors.
- Microsoft excel has a useful function to convert a screenshot of a table to a data file. This can speed up your data extraction. 
  - See here: https://support.microsoft.com/en-us/office/insert-data-from-picture-3c1bb58d-2c59-4bc0-b04a-a671a6868fd7 
  - This service also does this well: https://www.extracttable.com/

When you have finished creating that file and double checked it for errors:

- Rename it using the following pattern: lastname_firstname_summary_statistics.csv - e.g., hussey_ian_summary_statistics.csv

- Upload it to this Google Drive folder https://drive.google.com/drive/folders/1Cj_yN2bhkqJ9Y734GVMgQS3w-R7Dp_FZ?usp=sharing

  - Note that you don't have to copy its results into a Google Sheet, just upload the whole file to the folder.

  

## Run GRIM & GRIMMER on your summary statistics

- Go to https://errors.shinyapps.io/scrutiny/
- Click browse, then find and upload your lastname_firstname_summary_statistics.csv file. 
  - If you're using a Mac, to be able to select and upload your csv file, you'll have to click "Show Options" and then "Format: All Files".
- Change the setting labelled "Mean / percentage column:" from "x" to "mean", as the column of means is called "mean" in our file.
- Go to the "Consistency testing" tab in the web app. 
- Check that "Consistency test" is set to "GRIM".
- Click "Download results by case"
  - This will download a file called lastname_firstname_summary_statistics_GRIM.csv
- Change "Consistency test" is set to "GRIMMER".
- Click "Download results by case"
  - This will download a file called lastname_firstname_summary_statistics_GRIMMER.csv
- Examine the results presented on screen for GRIM and GRIMMER, specifically the "Consistency" column of the top table and "Visualisation" plot to its right. Consider the following questions, which we will discuss in class next week:
  - Are the reported statitsics useful to analyze with GRIM/MER? Ie if summary statistics are reported to two decimal places, is the N_participants * N_items less than 100?
  - Are the reported statitsics GRIM/MER consistent? 
  - If not, how close are they to possible results? Try using the "Dispersed sequences" plots and table to understand this.
- Upload both lastname_firstname_summary_statistics_GRIM.csv and lastname_firstname_summary_statistics_GRIMMER.csv files to the same Google Drive folder: https://drive.google.com/drive/folders/1Cj_yN2bhkqJ9Y734GVMgQS3w-R7Dp_FZ?usp=sharing
- I will analyze the results before class next week and present the summary to you.




