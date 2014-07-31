class Foxfire.Plot2dHelper
  @make-chart = ({selector, width, height, data}) ->
    <- nv.add-graph
    chart = nv.models.line-plus-bar-chart!
    |> ( .margin top: 30, right: 60, bottom: 50, left: 70 )
    |> ( .x (_,i) -> i )
    |> ( .y (d) -> d[1] )

    chart.x-axis.tick-format (d) ->
      dx = data[0].values[d] and data[0].values[d][0] and 0
      d3.time.format('%x')(new Date dx)

    chart.y1Axis.tick-format d3.format ',f'

    chart.y2Axis.tick-format (d) ->
      '$' + d3.format(',f')(d)

    chart.bars.force-y [0]

    d3.select selector
    |> ( .append "svg" )
    |> ( .attr "width", width )
    |> ( .attr "height", height )
    |> ( .datum data )
    |> ( .transition! )
    |> ( .duration 0 )
    |> ( .call chart )
    
    nv.utils.window-resize chart.update

    chart