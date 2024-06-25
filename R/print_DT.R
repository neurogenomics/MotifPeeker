#' Print DT table
#' 
#' @param df Dataframe/tibble to be printed.
#' @param html_tags Logical. If TRUE, returns the table as a tagList object.
#' @param extra Logical. If TRUE, adds extra options like search to the
#' datatable.
#' 
#' @importFrom DT datatable
#' @importFrom htmlwidgets JS
#' @importFrom htmltools tagList
#' 
#' @keywords internal
print_DT <- function(df, html_tags = FALSE, extra = FALSE) {
    ## Handle empty values
    rowCallback <- c(
        "function(row, data){",
        "  for(var i=0; i<data.length; i++){",
        "    if(data[i] === null){",
        "      $('td:eq('+i+')', row).html('NA')",
        "        .css({'color': 'rgb(151,151,151)'});",
        "    }",
        "  }",
        "}"  
    )
    
    if (!extra) {
        dt <- DT::datatable(df,
                            options = list(
                                pageLength = 50,
                                scrollX = "400px",
                                dom = "t",
                                rowCallback = htmlwidgets::JS(rowCallback)
                            ))
    } else {
        dt <- DT::datatable(df,
                            options = list(
                                pageLength = 50,
                                scrollX = "400px",
                                rowCallback = htmlwidgets::JS(rowCallback)
                            )
        )
    }
    
    if (html_tags) {
        return(htmltools::tagList(dt))
    } else {
        return(dt)
    }
}
