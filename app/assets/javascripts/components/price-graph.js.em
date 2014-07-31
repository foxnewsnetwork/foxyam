class Foxfire.PriceGraphComponent extends Ember.Component
  classNames: ['price-graph']

  +computed givenOrRandomId, prices
  visualGraph: ->
    Foxfire.Plot2dHelper.makeChart
      selector: "#" + @givenOrRandomId
      width: "100%"
      height: "300px"
      data: @prices

  didInsertElement: ->
   @visualGraph

  +computed domId
  givenOrRandomId: ->
    @get("domId") or "price-graph-#{@randomInt()}"

  randomInt: ->
    Math.floor 99999 * Math.random()