library(shiny)
library(tidyverse)
library(readxl)
library(shinythemes)



# passat <- read_excel("passat.xlsx")
# rt <- read_csv2("Rt_cases.csv")

passat <- read_excel("data/passat.xlsx")
rt <- read_csv2("data/Rt_cases.csv")

theme_set(theme_minimal())
options(scipen = 999)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Datavisualisering 2022", title = div(img(height = 100,
                                                       width = 125,
                                                       src = "DaniaLogo.png"))),
  theme = shinytheme("cosmo"),
  
  headerPanel("Dette er vores web-app"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      
      
      sliderInput("alpha", "Vælg transparenthed",
                  min = 0.1,
                  max = 1.0,
                  value = 0.5),
      
      sliderInput("size", "Vælg størrelse på punkter",
                  min = 1,
                  max = 20,
                  value = 5),
      
      sliderInput("price_adj", "Vælg max pris",
                  min = min(passat$price),
                  max = max(passat$price),
                  value = median(passat$price),
                  step = 10000),
      
      #textInput("title", "Skriv din titel her"),
      
      submitButton("Lav ændringer")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      "Her viser jeg mine plots",
      
      br(),
      br(),
      
      tabsetPanel(id = "tabs",
                  tabPanel("Plot",
                           br(),
                           selectInput("xaxis", "Vælg x-akse", choices = names(passat),
                                       selected = "km_per_liter", TRUE, multiple = FALSE),
                           
                           selectInput("yaxis", label = "Vælg y-akse", choices = names(passat),
                                       multiple = FALSE),
                           br(),
                           plotOutput("plot")),
                  
                  tabPanel("Tabel", tableOutput("tabel")),
                  
                  tabPanel("Corona-plot",
                           br(),
                           dateRangeInput(inputId = "rt_date", "Vælg datoer",
                                          start = "2020-04-01",
                                          end = Sys.Date(),
                                          max =  Sys.Date(),
                                          startview = "month",
                                          weekstart = 1),
                           plotOutput("covid_plot")))
      
    )
  )
)
