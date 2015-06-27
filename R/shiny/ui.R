
shinyUI(pageWithSidebar(
  headerPanel('Convertr Unit Explorer'),
  sidebarPanel(
    selectInput("base_unit",
                "Base Unit",
                c( "All",
                   unique(conversion_table$catalog_symbol)),
                selected = "m2")
  ),
  mainPanel(
    dataTableOutput("conversion")
  )
))

