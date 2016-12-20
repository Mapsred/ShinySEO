try(detach("package:SEO", unload=TRUE))
library(SEO)
library(shiny)
library(DT)
library(dygraphs)
library(shinyjs)
library(rhandsontable)

fluidPage(
  useShinyjs(), # on active shinyjs
  mainPanel(
    tabsetPanel(
      tabPanel("Recherche journalière",
               fluidPage(
                 titlePanel("Data Analystic - Recherche journalière"),
                 textInput(inputId = "titre", label = "URL à chercher"),
                 textAreaInput(inputId = "keywords_input", label = "Sur quel mot clef voulez-vous chercher le site ? Une expression par ligne"),
                 tableOutput("keywords_list"),
                 textOutput("display"),
                 actionButton(inputId = "go", "Envoyer"),
                 hr()
               )),
      tabPanel("Sommaire",
               fluidPage(
                 titlePanel("Data Analystic - Sommaire"),
                 h3("Évolution d'un mot clé"),
                 textInput(inputId = "summaryUrl", label = "URL à chercher", value = "www.thinkr.fr"),
                 textInput(inputId = "summaryWord", label = "Mot clé à chercher", value = "apprendre R"),
                 tableOutput("zone"),
                 actionButton(inputId = "summarySend", "Envoyer"),
                 hr(),
                 htmlOutput("titleSummary"),
                 htmlOutput("summaryTableTitle"),
                 htmlOutput("bestPosSummary"),
                 dataTableOutput("summaryTable"),
                 hr(),
                 htmlOutput("historyGlobalTitle"),
                 dataTableOutput("summaryGlobalDataTable")
               )),
      tabPanel("Historique",
               fluidPage(
                 titlePanel("Data Analystic - Historique"),
                 h3("Sites recherchés"),
                 tableOutput("urlHistory")
               )),
      tabPanel("Configuration",
          fluidPage(
            titlePanel("Configuration des sites"),
            mainPanel(
              dataTableOutput("keywordsForUrlDataTable")
            ),
            sidebarPanel(
              selectInput(inputId = "configForUrl", label = "Choisissez: ", choices = SEO::list_url_base()),
              actionButton(inputId = "showKeywordList", "Envoyer"),
              actionButton(inputId = "resetKeywordList", "Reset"),
              hr(),
              textAreaInput(inputId = "keywordToAppendForUrl", label = "Sur quel mot clef voulez-vous chercher le site ? Une expression par ligne"),
              actionButton(inputId = "addKeywordForUrl", "Ajouter")
            )
          )
      )
    )
  )
)






