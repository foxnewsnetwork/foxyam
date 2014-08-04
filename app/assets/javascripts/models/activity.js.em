a = DS.attr
class Foxfire.Activity extends DS.Model
  activity_type: a 'string'
  action_id: a 'string'
  seen_at: a 'date'
  related_pic: a 'string'
  account_id: a 'string'
  related_account_id: a 'string'
  material_name: a 'string'
  price_number: a 'number'
  location_name: a 'string'
  incoterm_name: a 'string'
  fulfilment_action_name: a 'string'
  fulfilment_summary: a 'string'

  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  +computed seen_at
  hasBeenSeen: ->
    false

  +computed related_account_id
  relatedAccount: ->
    @store.find "account", @get("related_account_id")
