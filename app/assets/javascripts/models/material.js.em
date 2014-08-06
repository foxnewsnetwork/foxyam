a = DS.attr
class Foxfire.Material extends DS.Model
  material_name: a "string"
  description: a "string"
  count: a "number"
  graph_created_at: a "date"

  +computed graph_created_at
  hasGraph: ->
    @get("graph_created_at")

  +computed id
  prices: ->
    @store.find "price_statistic", @get("id")

  +computed id
  quantities: ->
    @store.find "quantity_statistic", @get("id")

  +computed material_name, count_presentation
  presentation: ->
    [@get('material_name'), @get('count_presentation')].join " - "

  +computed count
  count_presentation: ->
    if 1000 < @get('count')
      Math.floor(@get('count') / 1000) + "K"
    else
      @get 'count'

  +computed material_name
  materialIcon: ->
    "fa-linux"
