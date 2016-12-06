try(detach("package:SEO", unload=TRUE))
library(SEO)
library(shiny)
library(DT)
library(dygraphs)


shinyServer(function(input, output, session) {
  string <- eventReactive(input$go,{input$titre})
  summaryUrl <- eventReactive(input$summarySend,{input$summaryUrl})
  summaryWord <- eventReactive(input$summarySend,{input$summaryWord})

  zoneText <- eventReactive(input$go, {input$zone})
  keyword_list <- eventReactive(input$go, {input$keywords_input})

  #Historique TAB
  output$urlHistory <- renderTable(SEO::list_url_base(), striped = TRUE, bordered = TRUE, colnames = FALSE)

  #Recherche journalière TAB
  output$display <- renderPrint({
    if (keyword_list() != "") {
      wordList <- strsplit(x = keyword_list(), split = "\n")[[1]]
      result <- SEO::daily_run(string(), wordList, 30)

      #output$keywords_list <- renderTable(wordList, striped = TRUE, hover = TRUE, bordered = TRUE, colnames = FALSE)
      cat("Recherche journalière effectuée")
    }
  })

  #Sommaire TAB
  output$zone <- renderPrint({
    #summaryUrl and summaryWord required
    if (summaryUrl() != "" && summaryWord() != "") {
      output$titleSummary <- renderText(HTML(sprintf("<h3>Évolution du mot clé <i>%s</i></h3>", summaryWord())))

      output$summaryTableTitle <- renderText(HTML("<h3>Historique </h3>"))
      bestPos <- SEO::get_best_position(summaryUrl(), summaryWord())
      output$bestPosSummary <- renderText(HTML(sprintf("<h4>Meilleure position : %s</h4>", bestPos)))

      output$summaryTable <- renderDataTable(SEO::get_all_position(summaryUrl(), summaryWord()))
    }

    #summaryUrl required
    if (summaryUrl() != "") {
      output$historyGlobalTitle <- renderText(HTML(sprintf("<h3>Historique de recherche pour <i>%s</i></h3>", summaryUrl())))
      output$summaryGlobalDataTable <- renderDataTable(data <- SEO::compare_position(summaryUrl()), escape=FALSE)
    }
  })



})

