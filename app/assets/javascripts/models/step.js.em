a = DS.attr
class Foxfire.Step extends DS.Model
  fulfilment_id: a 'string'
  account_id: a 'string'
  step_name: a 'string'
  status_key: a 'string'
  order_number: a 'number'

  +computed fulfilment_id
  fulfilment: ->
    @store.find "fulfilment", @get("fulfilment_id")

  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  +computed account_id
  actionAccount: -> 
    @store.find "account", @get("account_id")

  +computed id
  conversations: ->
    @store.find "conversation", step_id: @get("id")