try(detach("package:SEO", unload=TRUE))
library(SEO)
library(shiny)
library(DT)
library(dygraphs)
library(shinyjs)
library(rhandsontable)

fluidPage(
  useShinyjs(), # on active shinyjs
  titlePanel("Data Analystic"),
  textInput(inputId = "titre", label = "Input Text"),
  textAreaInput(inputId = "zone", label = "Text Area Input"),
  textAreaInput(inputId = "keywords_input", label = "Sur quel mot clef voulez-vous chercher le site ? Une expression par ligne"),

  textOutput("display"),
  textOutput("zone"),
  tableOutput("keywords_list"),
  actionButton(inputId = "go", "Envoyer")
)






