class Foxfire.Plot2dHelper
  @fake-data =
    * key: "Quantity"
      bar: true
      color: \#ccf
      values:
        * [1,1]
        * [2, 2]
        * [3, 3]
    * key: "Price"
      color: \#333
      values:
        * [1,1]
        * [2, 2]
        * [3, 3]

  @sort-data = (data) ->
    _.map data, (hash) ->
      hash.values = _.sort-by hash.values, (value) -> value[0]
      hash

  @make-chart = (element) ->
    container = Foxfire.Plot2dHelper.ContainerFormatter.transform element
    chart = Foxfire.Plot2dHelper.ChartMaker.create!
    new Foxfire.Plot2dHelper.LineBarChart container, chart

class Foxfire.Plot2dHelper.LineBarChart
  (@container, @chart) ->
  datum: (data) ->
    sorted-data = Foxfire.Plot2dHelper.sort-data data
    @container.datum sorted-data
    @chart.date-data = _.map sorted-data[0].values, ([date, x]) -> date
    @
  update: ->
    @chart.update! if @chart.update
    @
  render: ->
    @container.call @chart
    @

class Foxfire.Plot2dHelper.ChartMaker
  _chart-margins =
    top: 30
    right: 60
    bottom: 50
    left: 70

  _basic-chart = ->
    nv.models.line-plus-bar-chart!margin(_chart-margins)
  
  _format-basis = (chart) ->
    chart
      ..x (d, i) ->
        i
      ..y (d) -> 
        d[1]
  _format-axis = (chart) ->
    chart
      ..x-axis.tick-format (index) ->
        new Date chart.date-data[index] |> d3.time.format '%x' 
      ..y1Axis.tick-format d3.format ',f'
      ..y2Axis.tick-format (d) ->
        '$' + d3.format('.3r')(d)
      ..bars.force-y [0]

  @create = -> _basic-chart! |> _format-basis |> _format-axis

class Foxfire.Plot2dHelper.ContainerFormatter
  _to-d3svg = (dom-element) -> 
    d3.select(dom-element).append("svg").attr("width", "100%").attr("height", "300px")
  _format-transitions = (svg) -> 
    svg
      ..transition!duration 100
  @transform = (dom-element) -> dom-element |> _to-d3svg |> _format-transitions
