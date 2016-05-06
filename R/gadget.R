#'  Launch interactive conversion gadget
#'
#' @param vector
#' A numeric vector to convert. You can change the vector within the app.
#'
#' @return
#' Insert text into code with a proper convertr::convert() call.
#' @export
#'

convert_gadget  <- function(vector) {
  si_units <- unique(conversion_table$base_unit[conversion_table$multi_unit])
  si_units <- si_units[order(si_units)]

  if(missing(vector)){
    express <- "1:10"
  } else {
    express <- deparse(substitute(vector))
  }

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Unit Converter"),
    miniUI::miniContentPanel(
      shiny::fluidRow(
        shiny::column( width = 6,
                       shiny::selectInput("si_unit",
                                          "SI Unit",
                                          c("All", si_units))
        ),
        shiny::column( width = 6,
                       shiny::textInput("vector", "Epression Returning Numeric Vector",
                                        express)
        )
      ),
      shiny::fluidRow(
        shiny::column(width = 6,
                      shiny::uiOutput("from_unit")
        ),
        shiny::column( width = 6,
                       shiny::uiOutput("to_unit")
        )
      ),
      shiny::fluidRow(
        DT::dataTableOutput("table", width = "75%")
      )
    )
  )

  server <- function(input, output, session) {

    vector <- shiny::reactive(eval(parse( text = input$vector)))


    output$from_unit <- shiny::renderUI({

      if(input$si_unit == "All"){

        return(
          shiny::selectInput("from_unit", "From Unit",
                             unique(conversion_table$catalog_symbol))
        )
      } else {
        choices <- conversion_table[conversion_table$base_unit ==
                                      input$si_unit, "catalog_symbol"]

        shiny::selectInput("from_unit", "From Unit", unique(choices))
      }
    })

    output$to_unit <- shiny::renderUI({
      shiny::req(input$from_unit)
    #  browser()

      if(input$si_unit == "All"){

        if(input$from_unit != unique(conversion_table$catalog_symbol)[1]){
          base_unit <- conversion_table[conversion_table$catalog_symbol ==
                                          input$from_unit, "base_unit"]

          choices <- conversion_table[conversion_table$base_unit ==
                                        base_unit, "catalog_symbol"]
          return(shiny::selectInput("to_unit", "To Unit", unique(choices)))
        } else {
          choices <- unique(conversion_table$catalog_symbol)
          shiny::selectInput("to_unit", "To Unit", unique(choices))
        }
      }else {
        choices <- conversion_table[conversion_table$base_unit ==
                                      input$si_unit, "catalog_symbol"]
        shiny::selectInput("to_unit", "To Unit", unique(choices))
      }

    })


    output$table <- DT::renderDataTable({
      shiny::req(input$from_unit, input$to_unit)
      if(is.numeric(vector())){
        v1 <- vector()[1:min(length(vector()), 20)]
      } else{
        v1 <- 1:10
      }
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

    shiny::observeEvent(input$done, {

      code <- paste0("convertr::convert(",
                     input$vector,
                     ",'",
                     input$from_unit,
                     "','",
                     input$to_unit,
                     "')")
      shiny::stopApp(rstudioapi::insertText(code))

    })

  }

  shiny::runGadget(ui, server)
}

