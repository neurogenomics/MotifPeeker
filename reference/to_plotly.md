# Convert ggplot2 objects to plotly

Convert ggplot2 objects to plotly

## Usage

``` r
to_plotly(p, html_tags = TRUE, tooltip = "text", ...)
```

## Arguments

- p:

  ggplot2 object

- html_tags:

  Logical. If TRUE, returns the plot as a `tagList` object.

- tooltip:

  Character. The tooltip to display. Default is "text".

- ...:

  Arguments passed on to
  [`plotly::ggplotly`](https://rdrr.io/pkg/plotly/man/ggplotly.html)

  `width`

  :   Width of the plot in pixels (optional, defaults to automatic
      sizing).

  `height`

  :   Height of the plot in pixels (optional, defaults to automatic
      sizing).

  `dynamicTicks`

  :   should plotly.js dynamically generate axis tick labels? Dynamic
      ticks are useful for updating ticks in response to zoom/pan
      interactions; however, they can not always reproduce labels as
      they would appear in the static ggplot2 image.

  `layerData`

  :   data from which layer should be returned?

  `originalData`

  :   should the "original" or "scaled" data be returned?

  `source`

  :   a character string of length 1. Match the value of this string
      with the source argument in
      [`event_data()`](https://rdrr.io/pkg/plotly/man/event_data.html)
      to retrieve the event data corresponding to a specific plot (shiny
      apps can have multiple plots).

## Value

A `plotly` object.

## See also

[ggplotly](https://rdrr.io/pkg/plotly/man/ggplotly.html)

## Examples

``` r
x <- data.frame(a = c(1,2,3), b = c(2,3,4))
p <- ggplot2::ggplot(x, ggplot2::aes(x = a, y = b)) + ggplot2::geom_point()
MotifPeeker:::to_plotly(p, html_tags = FALSE)

{"x":{"data":[{"x":[1,2,3],"y":[2,3,4],"text":"","type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,0,0,1)","opacity":1,"size":5.6692913385826778,"symbol":"circle","line":{"width":1.8897637795275593,"color":"rgba(0,0,0,1)"}},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":23.305936073059364,"r":7.3059360730593621,"b":37.260273972602747,"l":43.105022831050235},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.90000000000000002,3.1000000000000001],"tickmode":"array","ticktext":["1.0","1.5","2.0","2.5","3.0"],"tickvals":[1,1.5,2,2.5,3],"categoryorder":"array","categoryarray":["1.0","1.5","2.0","2.5","3.0"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0,"zeroline":false,"anchor":"y","title":{"text":"a","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1.8999999999999999,4.0999999999999996],"tickmode":"array","ticktext":["2.0","2.5","3.0","3.5","4.0"],"tickvals":[2,2.5,3,3.5,4],"categoryorder":"array","categoryarray":["2.0","2.5","3.0","3.5","4.0"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0,"zeroline":false,"anchor":"x","title":{"text":"b","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","layer":"below","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.68949771689498}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"6e6028e685a":{"x":{},"y":{},"type":"scatter"}},"cur_data":"6e6028e685a","visdat":{"6e6028e685a":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
