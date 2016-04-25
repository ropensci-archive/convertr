convert_gadget  <- function(vector) {

  ui <- miniPage(
    gadgetTitleBar("Unit Converter"),
    miniContentPanel(
      fluidRow(
        selectInput("si_unit",
                    "SI Unit",
                    c("All", unique(conversion_table$base_unit))),
        textInput("vector", "Vector", deparse(substitute(vector)))
      ),
      fluidRow(
        column(width = 6,
               uiOutput("from_unit")
        ),
        column( width = 6,
                uiOutput("to_unit")
        )
      ),
      fluidRow(
        DT::dataTableOutput("table", width = "75%")
      )
    )
  )

  server <- function(input, output, session) {

    vector <- reactive(eval(parse( text = input$vector)))


    output$from_unit <- renderUI({

      if(input$si_unit == "All"){

        return(
          selectInput("from_unit", "From Unit",
                      unique(conversion_table$catalog_symbol))
        )
      } else {
        choices <- conversion_table[conversion_table$base_unit ==
                                      input$si_unit, "catalog_symbol"]
        selectInput("from_unit", "From Unit", unique(choices))
      }
    })

    output$to_unit <- renderUI({

      if(input$si_unit == "All"){
        selectInput("to_unit", "To Unit",
                    unique(conversion_table$catalog_symbol))
      } else {
        choices <- conversion_table[conversion_table$base_unit ==
                                      input$si_unit, "catalog_symbol"]
        selectInput("to_unit", "To Unit", unique(choices))
      }
    })


    output$table <- DT::renderDataTable({
      v1 <- vector()[1:min(length(vector()), 20)]
      v2 <- convert(v1, input$from_unit, input$to_unit)
      out <- data.frame(From = v1, To = v2)
      names(out) <- c(conversion_table[conversion_table$catalog_symbol ==
                                         input$from_unit, "name"],
                      conversion_table[conversion_table$catalog_symbol ==
                                         input$to_unit, "name"])
      out
    }, options = list(searching = FALSE, paging = FALSE),
    rownames = FALSE)


    # When the Done button is clicked, return a value

    observeEvent(input$done, {

      code <- paste0("convert(",
                     input$vector,
                     ",'",
                     input$from_unit,
                     "','",
                     input$to_unit,
                     "')")
      stopApp(rstudioapi::insertText(code))

    })

  }

  runGadget(ui, server)
}

