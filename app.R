library(shiny)

ui <- pageWithSidebar(

  headerPanel('Iris k-means clustering'),

  sidebarPanel(
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),

  mainPanel(
    plotOutput('plot')
  )
)

server <- function(input, output, session) {
  df <- iris[, c("Sepal.Length", "Sepal.Width")]

  clusters <- reactive({kmeans(df, input$clusters)})

  output$plot <- renderPlot({
    ggplot(df, aes(x=Sepal.Length, y=Sepal.Width,
      color=factor(clusters()$cluster))) + geom_point(size=5)
  })

}

shinyApp(ui=ui, server=server)

