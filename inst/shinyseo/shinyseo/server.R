try(detach("package:SEO", unload=TRUE))
library(SEO)
library(shiny)
library(DT)
library(dygraphs)


shinyServer(function(input, output, session) {
  string <- eventReactive(input$go,{input$titre})
  zoneText <- eventReactive(input$go, {input$zone})

  output$display <- renderPrint({
    cat(string())
  })

  output$zone <- renderPrint({
    cat(zoneText())
  })



})

