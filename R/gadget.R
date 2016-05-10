#' @title  Launch interactive conversion gadget
#'
#' @description It's often difficult to remember the symbol for the units you want to convert.
#' This gadget shows which units can be converted to one anohter, and a example calculation on sample data.
#' On exit you can either return a valid \code{convert()} expression or a
#' converted numeric vector.
#'
#' @param vector
#' A numeric vector to convert. You can change the vector within the app.
#'
#' @param return_value
#' By default the gadget generates a \code{convert()} call, if return_value is set to
#' TRUE it will instead generate a converted vector.
#' @return
#' Insert output text into editor.
#' @export
#'

convert_gadget  <- function(vector, return_value = FALSE) {
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
        shiny::column(width = 6),
        shiny::column(width = 6,
                      shiny::textOutput("error_text"))
      ),
      shiny::br(),
      shiny::fluidRow(
        shiny::column(width = 6,
                      shiny::uiOutput("from_unit")
        ),
        shiny::column( width = 6,
                       shiny::uiOutput("to_unit")
        )
      ),

      shiny::fluidRow(
        DT::dataTableOutput("table")
      )
    )
  )

  server <- function(input, output, session) {

    vector <- shiny::reactive(
      try(eval(parse( text = input$vector)), silent = TRUE)
    )

    output$error_text <- renderText({
      if(!is.numeric(vector())){
        "Cannot return numeric vector, using default values (1:10)"
      }
    })


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

      if(input$si_unit == "All"){

        if(input$from_unit != unique(conversion_table$catalog_symbol)[1]){
          base_unit <- conversion_table[conversion_table$catalog_symbol ==
                                          input$from_unit, "base_unit"]

          choices <- conversion_table[conversion_table$base_unit ==
                                        base_unit, "catalog_symbol"]
          return(shiny::selectInput("to_unit", "To Unit", unique(choices)))
        } else {
          choices <- unique(conversion_table$catalog_symbol)
          return(shiny::selectInput("to_unit", "To Unit", unique(choices)))
        }
      }else {
        choices <- conversion_table[conversion_table$base_unit ==
                                      input$si_unit, "catalog_symbol"]
        return(shiny::selectInput("to_unit", "To Unit", unique(choices)))
      }

    })


    output$table <- DT::renderDataTable({
      shiny::req( input$to_unit)
      if(is.numeric(vector())){
        v1 <- vector()[1:min(length(vector()), 20)]
      } else{
        v1 <- 1:10
      }
      v2 <- tryCatch(
        convert(v1, input$from_unit, input$to_unit),
        error = function(c) v1
      )


      out <- data.frame(From = v1, To = v2)
      names(out) <- c(conversion_table[conversion_table$catalog_symbol ==
                                         input$from_unit, "name"],
                      conversion_table[conversion_table$catalog_symbol ==
                                         input$to_unit, "name"])
      out

    }, options = list(searching = FALSE, paging = FALSE, dom = ""),
    rownames = FALSE)


    # When the Done button is clicked, return a value

    shiny::observeEvent(input$done, {
      if(return_value) {
        out <-  convert(vector(),
                        input$from_unit,
                        input$to_unit)
        text <- paste0("c(", paste(out, collapse = ", "), ")")
        shiny::stopApp(rstudioapi::insertText(text))
      } else {

        code <- paste0("convertr::convert(",
                       input$vector,
                       ",'",
                       input$from_unit,
                       "','",
                       input$to_unit,
                       "')")
        shiny::stopApp(rstudioapi::insertText(code))
      }

    })

  }

  shiny::runGadget(ui, server)
}

