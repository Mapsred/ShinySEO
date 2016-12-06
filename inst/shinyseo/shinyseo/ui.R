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

  textOutput("display"),
  textOutput("zone"),
  actionButton(inputId = "go", "Envoyer")
)






