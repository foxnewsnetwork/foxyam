a = DS.attr
class Foxfire.Step extends DS.Model
  fulfilment_id: a 'string'
  step_name: a 'string'
  status: a 'string'
  order_number: a 'number'

  +computed fulfilment_id
  fulfilment: ->
    @store.find "fulfilment", @get("fulfilment_id")