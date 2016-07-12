library(shiny)
library(RSQLite)
source('predict.R')

shinyServer(function(input, output) {

  dbout <- reactive({predict(input$text)})
  
  output$sentence <- renderText({input$text})
  output$predicted <- renderUI({
    out <- dbout()
    out_str = ''
    for(i in 1:length(out)){
      out_str <- paste0(out_str, "<li>", as.character(out[i]), "</li>")
    }
    HTML(paste0("<ul style='list-style: none;'>", out_str, "</ul>"))
    #HTML(paste0(out_str))
    })
})