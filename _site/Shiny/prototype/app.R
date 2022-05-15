library(shiny)
library(tidyverse)
library(tools)

exam <- read_csv("data/Exam_data.csv")

#default side is 4, main is 8 

ui <- fluidPage(
  titlePanel("Pupils Examination Result Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value = 10),
      textInput(
        inputId = "plot_title",
        label = "Plot Title",
        placeholder = "Enter text to be used as plot title"),
      actionButton(inputId = "goButton",
                   "Go!")

          ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    input$goButton
    
    x <- unlist(exam[,input$variable])
    ggplot(data = exam, aes(x))+
      geom_histogram(bins =input$bins,
                     color = 'black',
                     fill = "light blue") +
      labs(title= isolate({
        toTitleCase(input$plot_title)
      }))
  })
}

shinyApp(ui = ui, server=server)




  
  
  
  
  
  