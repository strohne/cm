#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#
# Packages ----
#

library(shiny)
library(tidyverse)
library(lubridate)


#
# Load data ----
#



data.in <- read_csv2("events_africa2016.zip")
countries <- unique(data.in$country.code)

#
# User Interface ----
#

ui <- fluidPage(

    sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(
            selectInput(
                "metrics",
                "Metriken",
                c("fatalities","mentions.all","mentions.violence"),
                selected="fatalities",
                multiple =T
            ),
            
            selectInput(
                "countries",
                "Länder",
                countries,
                selected=countries,
                multiple =T
            ),            
            
            selectInput(
                "unit",
                "Auflösung",
                c("day","week","month")
            ),
            
            dateRangeInput(
                "range",
                "Zeitfenster",
                start="2016-01-01",
                end="2016-12-31",
                language="de"
            )
 
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            # Application title
            titlePanel("News and fatalities in African countries"),
            
            plotOutput("view_plot")
        ),
        position = "right"
        
    )
)

#
# Server logic to create the plot ----
#

server <- function(input, output) {

    
    # Calculate
    data <- reactive({

        
        data.in %>% 

            filter(
                country.code %in% input$countries
            ) %>% 
            
            mutate(date = floor_date(date,unit=input$unit)) %>% 
            
            group_by(date) %>% 
            
            summarize(
                mentions.violence=sum(mentions.violence),
                mentions.all=sum(mentions.all),
                fatalities = sum(fatalities)
            ) %>% 
            
            filter(
                date >= input$range[1],
                date <= input$range[2]
            ) %>% 
            
        
            pivot_longer(
                input$metrics,
                names_to="metric"
            ) 
            
    })

    # Datensatz
    output$view_plot <- renderPlot({

        ggplot(data(),aes(x=date,y=value,color=metric)) +
            geom_line() +
            theme_bw() +
            theme(legend.position = "bottom") 
            
            
    })
   
}


#
# Run the application  ----
#

shinyApp(ui = ui, server = server)
