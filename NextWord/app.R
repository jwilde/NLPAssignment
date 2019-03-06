source("model.R")

library(shiny)
library(shinythemes)

predicted<-getNextWord('', 10)
  
# Define UI for application that draws a histogram
ui <- navbarPage("Next Word", 
                 theme=shinytheme("united"),
  #cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, slate, spacelab, superhero, united, yeti.
  
  tabPanel("Welcome",
           h3("Welcome!"),
           
          
           h5("Here you can write your own text and are supported by a predictive algorithm."),
           h5("While typing the algorithm gives you suggestions for the next word you might want to type. The algorith is based on data provided by SwiftKey."),
           br(),
           h4("How it works"),
           h5("You simply start typing inside the 'Write your text here:' field."),
           h5("Beneath the text input field, the algorithm shows you some suggestions for words you might want to type next."),
           h5("You can choose one word by simply clicking on it. The word is than added to your text."),
           h5("Try it out!"),
           img(src = "Wordcloud.png"),
           hr(),
           tags$footer("@J.Wilde, Munich 2019")
  ),
  
  tabPanel("Application",
   
    mainPanel(
      textAreaInput("typed", h4("Write your text here:"), width = 500, height = 300),
      #h5(textOutput("prediction")),
      actionButton('B1', ""),
      actionButton('B2', ""),
      actionButton('B3', ""),
      actionButton('B4', ""),
      actionButton('B5', ""),
      actionButton('B6', ""),
      actionButton('B7', ""),
      actionButton('B8', ""),
      actionButton('B9', ""),
      actionButton('B10', ""),
      hr(),
      tags$footer("@J.Wilde, Munich 2019")
      )
   
  )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
   #output$prediction<-renderText({
   #  predicted<-getNextWord(input$typed, model, 10)
   #  predicted
   #  })
   
   
   observeEvent(input$typed, {
     predicted<-getNextWord(input$typed, 10)
     updateActionButton(session, "B1", label = predicted[1])
     updateActionButton(session, "B2", label = predicted[2])
     updateActionButton(session, "B3", label = predicted[3])
     updateActionButton(session, "B4", label = predicted[4])
     updateActionButton(session, "B5", label = predicted[5])
     updateActionButton(session, "B6", label = predicted[6])
     updateActionButton(session, "B7", label = predicted[7])
     updateActionButton(session, "B8", label = predicted[8])
     updateActionButton(session, "B9", label = predicted[9])
     updateActionButton(session, "B10", label = predicted[10])
   })
   
   observeEvent(input$B1, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[1]))
   })
   
   observeEvent(input$B2, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[2]))
   })
   
   observeEvent(input$B3, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[3]))
   })
   
   observeEvent(input$B4, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[4]))
   })
   
   observeEvent(input$B5, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[5]))
   })
   
   observeEvent(input$B6, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[6]))
   })
   
   observeEvent(input$B7, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[7]))
   })
   
   observeEvent(input$B8, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[8]))
   })
   
   observeEvent(input$B9, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[9]))
   })
   
   observeEvent(input$B10, {
     predicted<-getNextWord(input$typed, 10)
     updateTextAreaInput(session, "typed", value = paste(input$typed, predicted[10]))
   })
  # output$prediction1<-renderText({"test"})
  
}

# Run the application 
shinyApp(ui = ui, server = server)

