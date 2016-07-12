library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("N-Gram Word Predictor"),
  h4("Yashu Seth", style="color:gray"),
  hr(),
  
  fluidRow(width=2,
           p("Enter a sentence, hit enter (or press the 'Predict next' button), and see what the 
             algorithm predicts.."),
           p("The underlying model is an",
             a(href="http://en.wikipedia.org/wiki/N-gram", "n-gram"),
             "model, from a dataset of Twitter, news articles, 
             and blog posts. It uses 'Stupid Backoff' 
             to deal with the unseen n-grams.")),
  hr(),
  
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = h3("Input"), value = "I love"),
      helpText("Type in a sentence above, hit enter (or press the button below), and the results will display to the right."),
      submitButton("Predict next"),
      hr()
    ),
    
    mainPanel(
      br(),
      h2(textOutput("sentence"), align="center"),
      h3("Top Possibilities:", align="center"),
      h1(htmlOutput("predicted"), align="center", style="color:blue"),
      hr()
    )
  )
  ))