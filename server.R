library(shiny)
library(tidyverse)
library(readxl)
library(shinythemes)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    passat_adj <- passat %>%
      filter(price <= input$price_adj)
    
    ggplot(data = passat_adj, aes_string(x = as.name(input$xaxis), y = as.name(input$yaxis))) +
      geom_point(size = input$size, alpha = input$alpha) +
      labs(title = paste0("Her er sammenhængen mellem ", as.name(input$xaxis),
                          " og ", as.name(input$yaxis)),
           subtitle = paste0("Her vises biler der koster mindre end ", input$price_adj, " kroner")) +
      theme(plot.title = element_text(size = 30),
            plot.subtitle = element_text(size = 20),
            axis.title = element_text(size = 20))
    
  })
  
  output$tabel <- renderTable({
    
    pas_adj <- passat %>%
      filter(price <= input$price_adj)
    
    print(pas_adj)
    
  })
  
  output$covid_plot <- renderPlot({
    
    rt2 <- rt %>%
      
      filter(SampleDate >= as.Date(input$rt_date[1]) & SampleDate <= as.Date(input$rt_date[2]))
    
    p <- ggplot(data = rt2, aes(x = as.Date(SampleDate), y = estimate)) +
      geom_line() +
      geom_hline(yintercept = 1, color = "red", size = 2, alpha = 0.5) +
      labs(x = "Dato",
           y = "Kontakttal")
    
    print(p)
    
  })
  
}














# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#   
#   output$distPlot <- renderPlot({
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#   })
# }
