
shinyUI(pageWithSidebar(
  headerPanel('Convertr Unit Explorer'),
  sidebarPanel(
    selectInput("base_unit",
                "Base Unit",
                c( "All",
                   unique(conversion_table$base_unit)),
                selected = "1/a")
  ),

  mainPanel(
    dataTableOutput("conversion")
  )
))

