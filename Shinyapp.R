#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

## Get libraries going
library(data.table)
library(DT)
library(shiny)

## Create relevant objects

# Load data file for merged personnel
personnelmerge <- read.csv("RDPMergedpersonnel.csv")
# Rename columns
setnames(personnelmerge, c("Term.Status", "Term.Expires", "Must.Vacate.Seat.By", "Nomination.Status", "Latest.Action", "Dated.Received.from.President", "Replaced..Replacing", "Additional.Notes"), c("Term Status", "Term Expires", "Must Vacate Seat By", "Nomination Status", "Latest Action", "Date Received from President", "Replaced/ Replacing", "Additional Notes")) 

# Load data file for agency info
agencyinfo <- read.csv("RDPAgencyinfo.csv")

# Rename columns
setnames(agencyinfo, c("Voting.Members", "Appointed.members..subject.to.Senate.confirmation.for.THIS.post", "Enough.for.quorum.", "Political.balance.required.", "Senate.Committee.with.Jurisdiction", "Republican.Vacancies", "Democrat.Vacancies", "Serving.expired.terms", "Republican.Serving.Expired.Terms", "Democrat.Serving.Expired.Terms", "Pending.nominations"), c("Voting Members", "Appointed Members (requiring Senate confirmation for THIS seat)", "Enough for quorum?", "Political balance required?", "Senate Committee with Jurisdiction", "Republican Vacancies", "Democrat Vacancies", "Serving Expired Terms", "Republicans Serving Expired Terms", "Democrats Serving Expired Terms", "Pending Nominations")) 


# Define UI for application
ui <- fluidPage(
   
   # Application title
   titlePanel("Revolving Door Project - Independent Federal Agency Monitor"),
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Agencies - Overview", DT::dataTableOutput("agencyinfo")),
          tabPanel("Agencies - Personnel", DT::dataTableOutput("personnelmerge"))
        )
      )
   )
# Define server logic
server <- function(input, output) {output$agencyinfo <- DT::renderDataTable({DT::datatable(agencyinfo, options = list(pageLength = 25))})
output$personnelmerge <- DT::renderDataTable({DT::datatable(personnelmerge, options = list(pageLength = 25))})}

# Run the application 
shinyApp(ui = ui, server = server)

