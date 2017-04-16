library(shiny)


shinyApp(

  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(

      checkboxGroupInput("checkGroup", label = h3("Checkbox group"),
                         choices = list("Choice 1" = 1, "Choice 2" = 2), selected = 1)
    ),
    dashboardBody(
      uiOutput('mytabs')
  )
  ),

  server = function(input, output, session){
    output$mytabs = renderUI({
     #  collection = c(
     #   tabPanel( "one panel",  plotOutput("carPlot")),
     #     tabPanel("two panel", sliderInput("cIDemoCL", "Confidence Level %", value = 80, min = 80, max = 99, step = 5))
     # )
          #newTabs =tabPanel( "one panel",  plotOutput("carPlot"))
        # myTabs = lapply(input$checkGroup, tabPanel)

      newTabPanels <- list(
        tabPanel("One Prop",
                 actionButton("Button", "Some new button!"),
                 plotOutput("carPlot")
        ),
        tabPanel("CI", sliderInput("Slider", label = NULL, min = 0, max = 1, value = 1))
      )

      collectNewTabs = newTabPanels[c(as.numeric(input$checkGroup))]
         do.call(tabsetPanel, collectNewTabs)
    })


   output$carPlot = renderPlot({
     print(ggplot(data = cars, aes(x = speed, y = dist))+geom_point())

   })
  }
)


shinyApp(ui, server)
