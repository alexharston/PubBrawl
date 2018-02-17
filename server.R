#shinyServer(function(input, output) {
#
#  output$distPlot <- renderPlot({
#
#    # generate bins based on input$bins from ui.R
#    x    <- faithful[, 2]
#    bins <- seq(min(x), max(x), length.out = input$bins + 1)
#
#    # draw the histogram with the specified number of bins
#    hist(x, breaks = bins, col = 'darkgray', border = 'white')
#
#  })
#  
#  output$map <- google_map(key = key)
#
#
#})


server <- function(input, output){
  
  output$map <- renderGoogle_map({
    google_map(key = key) %>%
      add_drawing(drawing_modes = c("circle"))
  })
  
  
  observeEvent(input$map_circlecomplete, {
    print(input$map_circlecomplete)
  })
}
