class Foxfire.PriceGraphComponent extends Ember.Component
  classNames: ['price-graph']
  alreadyInitialized: false
  
  +computed domId
  givenOrDefaultId: ->
    @domId or "price-graph-#{@randomInt()}"

  +computed givenOrDefaultId
  givenOrDefaultSelector: ->
    '#' + @givenOrDefaultId

  +computed priceQuants, d3Chart
  visualGraph: ->
    return unless @priceQuants and @d3Chart
    @d3Chart.datum(@priceQuants).render() or true

  +computed quantityValues, priceValues
  priceQuants: ->
    return unless @get("quantityValues") and @get("priceValues")
    [
      {
        key: "Quantity", 
        bar: true,
        color: "#ccf",
        values: @get("quantityValues")
      },
      {
        key: "Price",
        color: "#333",
        values: @get("priceValues")
      }
    ]

  +computed quantities.quantities.@each, quantities.dates.@each
  quantityValues: ->
    return unless @get("quantities.dates") and @get("quantities.quantities")
    _.zip @get("quantities.dates"), @get("quantities.quantities")


  +computed prices.prices.@each, prices.dates.@each
  priceValues: ->
    return unless @get("prices.dates") and @get("prices.prices")
    _.zip @get("prices.dates"), @get("prices.prices")

  +computed givenOrDefaultSelector, alreadyInitialized
  graphElement: ->
    return unless @alreadyInitialized
    @$(@givenOrDefaultSelector)[0]

  +computed graphElement
  d3Chart: ->
    return unless @graphElement
    Foxfire.Plot2dHelper.makeChart @graphElement

  randomInt: ->
    Math.floor 100000 * Math.random()

  bindWindowResize: ->
    @oldResizeFun = window.onresize
    window.onresize = =>
      @d3Chart.update()
      @oldResizeFun() if @oldResizeFun

  unbindWindowReseize: ->
    window.onresize = @oldResizeFun

  willDestroyElement: ->
    @unbindWindowReseize()
    @_super()

  didInsertElement: ->
    @alreadyInitialized = true
    @bindWindowResize()