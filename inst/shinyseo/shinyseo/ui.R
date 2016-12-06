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
                 titlePanel("Data Analystic"),
                 textInput(inputId = "titre", label = "URL à chercher"),
                 textAreaInput(inputId = "keywords_input", label = "Sur quel mot clef voulez-vous chercher le site ? Une expression par ligne"),
                 tableOutput("keywords_list"),
                 textOutput("display"),
                 actionButton(inputId = "go", "Envoyer")
               )),
      tabPanel("Summary"),
      tabPanel("Table")
    )
  ),




  textOutput("zone")

)






