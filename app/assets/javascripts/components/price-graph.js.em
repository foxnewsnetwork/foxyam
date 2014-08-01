class Foxfire.PriceGraphComponent extends Ember.Component
  classNames: ['price-graph']

  +computed givenOrRandomId, priceQuants
  visualGraph: ->
    return unless @priceQuants
    Foxfire.Plot2dHelper.makeChart
      selector: "#" + @givenOrRandomId
      width: "100%"
      height: "300px"
      data: @priceQuants
    true

  +computed prices.values, quantities.values
  priceQuants: ->
    return unless @get("prices.values") and @get("quantities.values")
    [
      {
        key: "Quantity", 
        bar: true,
        color: "#ccf",
        values: @get("quantities.values")
      },
      {
        key: "Price",
        color: "#333",
        values: @get("prices.values")
      }
    ]

  didInsertElement: ->
   @visualGraph

  +computed domId
  givenOrRandomId: ->
    @get("domId") or "price-graph-#{@randomInt()}"

  randomInt: ->
    Math.floor 99999 * Math.random()