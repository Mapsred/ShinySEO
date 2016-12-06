try(detach("package:SEO", unload=TRUE))
library(SEO)
library(shiny)
library(DT)
library(dygraphs)


shinyServer(function(input, output, session) {
  string <- eventReactive(input$go,{input$titre})
  zoneText <- eventReactive(input$go, {input$zone})
  keyword_list <- eventReactive(input$go, {input$keywords_input})


  output$display <- renderPrint({
    cat(string())
  })

  output$zone <- renderPrint({
    cat(zoneText())
  })


  output$keywords_list <- renderTable(strsplit(x = keyword_list(), split = "\n")[[1]], striped = TRUE, hover = TRUE, bordered = TRUE)





})

