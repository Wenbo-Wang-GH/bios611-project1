library(shiny)
library(tidyverse)

args <- commandArgs(trailingOnly=T);

port <- as.numeric(args[1]);

covid <- readRDS("derived_data/covid.csv")

ui <- fluidPage(
	titlePanel("Age vs. Mortality - Preconditions"),
	fluidRow(
		sidebarPanel(
			
		div("Select Precondition"),
		
		selectInput(
			"variable",
			"Select",
			selected = NULL,
			choices = c("intubation" = "intubed", 
									"pneumonia", "pregnancy", "diabetes", "copd", "asthma", 
									"immunosuppressed" = "inmsupr", 
									"hypertension", "cardiovascular", "obesity", "chronic kidney failure" = "renal_chronic", 
									"tobacco"),
			multiple = FALSE
			)
		),
		mainPanel(
		plotOutput("plot1"),
		tags$h6("This RShiny program allows one to view how different health preconditions affect the prevalence of mortality in different age groups. In our report, we were able to show the results for one patient characteristic; this app is a convenient way to view the results for more variables.")
		)
	)
)

server <- function(input, output) {
	
	output$plot1 <- renderPlot({
		select <- input$variable
		labs <- levels(covid[,select])
			labs[labs == "1"] <- "Yes"
			labs[labs == "2"] <- "No"
			labs[labs == "97"] <- "NA"
			labs[labs == "98"] <- "Ignored"
			labs[labs == "99"] <- "Not Specified"
		ggplot(covid, aes(dependent, age, fill=get(select))) +
			geom_violin() + scale_fill_discrete(name=select,labels=labs) +
			xlab("Mortality") + ylab("Age")
	})
}

print(sprintf("Starting shiny on port %d", port));
shinyApp(ui = ui, server = server, options = list(port=port, host="0.0.0.0"))


