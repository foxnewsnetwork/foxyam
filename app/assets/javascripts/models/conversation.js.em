a = DS.attr
class Foxfire.Conversation extends DS.Model
  offer_id: a "number"
  +computed offer_id
  offer: ->
    @store.find "offer", @get("offer_id")

  account_id: a "number"
  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  created_at: a "date"
  +computed created_at
  created_at_ago: ->
    $.timeago @get "created_at"
  icon_type: a "string"
  summary: a "string"