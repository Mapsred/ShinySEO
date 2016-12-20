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
  website_history <- eventReactive(input$showKeywordList, { input$configForUrl })
#  keyword_to_append <- eventReactive(input$addKeywordForUrl, { SEO::word_list_to_bdd(site_url = website_history(), word_list = input$keywordToAppendForUrl, append = TRUE) })

  #Historique TAB
  output$urlHistory <- renderTable(SEO::list_url_base(), striped = TRUE, bordered = TRUE, colnames = FALSE)

  #Recherche journalière TAB
  output$display <- renderPrint({
    if (keyword_list() != "") {
      wordList <- strsplit(x = keyword_list(), split = "\n")[[1]]
      result <- SEO::daily_run(string(), wordList, 30)

      output$keywords_list <- renderTable(wordList, striped = TRUE, hover = TRUE, bordered = TRUE, colnames = FALSE)
      cat("Recherche journalière effectuée")
    }
  })

  #Sommaire TAB
  output$zone <- renderPrint({
    if (summaryUrl() != "") {
      output$keywordsForUrlDataTable <- renderDataTable(expr = SEO::bdd_to_word_list(summaryUrl()))
    }
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

  # Configuration des sites (mots clefs a rechercher)
  output$keywordsForUrlDataTable <- renderDataTable(expr = SEO::bdd_to_word_list( website_history() ) )
  # Reset word_list
  observeEvent(input$resetKeywordList, {
    SEO::word_list_to_bdd(site_url = website_history(), word_list = "", append = FALSE)
    website_history()
  })

  observeEvent(input$addKeywordForUrl, {
    SEO::word_list_to_bdd(site_url = website_history(), word_list = input$keywordToAppendForUrl, append = TRUE)
  })

})

