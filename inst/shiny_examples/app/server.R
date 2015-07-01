
shinyServer(function(input, output) {

  output$conversion <- renderDataTable({
    df <- conversion_table
    if( input$base_unit != "All" ){
      df <- df[ df$base_unit == input$base_unit, ]
    }
    df
    })
})
