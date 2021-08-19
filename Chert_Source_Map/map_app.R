#load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)
library(tidyverse)
library(sf)
library(leafpop)
#import data


icons <- awesomeIcons(
  icon = "A",
  markerColor = "orange")

#RMmap <- leaflet() %>% 
  #addTiles() %>% 
  #addProviderTiles(provider = "Esri.WorldImagery") %>% 
  #addMarkers(lng = data$lat, lat = data$long, popup = data$Sample) %>% 
  #addAwesomeMarkers(lng = data$lat, lat = data$long, label = data$Sample, icon = icons, 
                    #popup = paste("Site:", data$Name, "<br>",
                                 # "Latitude:", data$long, "<br>",
                                 # "Longitude:", data$lat, "<br>",
                                 # "Description:", data$Observations))

#RMmap

ui <- fillPage(
 leafletOutput("map", width = "100%", height = "100%"),
              tags$style(type = "text/css", "html, body {width:100%; height:100%}"),
              fluidRow(verbatimTextOutput("map_marker_click"))
    )

  
server <- function(input, output, session) {
  
  data <- read_csv("C:/Users/Meran/Documents/PhD/R projects/Chert_Sources_Map/Data/chert_field.csv")
  
  
  
  output$map <- renderLeaflet({
    leaflet() %>%
      #addTiles() %>% 
      addProviderTiles(provider = "Esri.WorldImagery") %>% 
      #addMarkers(lng = data$lat, lat = data$long, popup = data$NewCode) %>% 
      addAwesomeMarkers(lng = data$long, lat = data$lat, label = data$NewCode, icon = icons, 
                        popup = paste("Site:", data$Name, "<br>",
                                      "Latitude:", data$lat, "<br>",
                                      "Longitude:", data$long, "<br>",
                                      "Description:", data$Observations))
  })
    observeEvent(input$map_marker_click, { 
      p <- input$map_marker_click  # typo was on this line
      print(p)
    })
}

shinyApp(ui, server)
