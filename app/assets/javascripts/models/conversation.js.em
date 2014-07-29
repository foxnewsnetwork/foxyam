a = DS.attr
class Foxfire.Conversation extends DS.Model
  offer_id: a "number"
  step_id: a "string"
  account_id: a "number"
  created_at: a "date"
  icon_type: a "string"
  summary: a "string"

  +computed step_id
  step: ->
    @store.find "step", @get("step_id")
    
  +computed offer_id
  offer: ->
    @store.find "offer", @get("offer_id")

  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  +computed created_at
  created_at_ago: ->
    $.timeago @get "created_at"

  +computed id
  attachments: ->
    @store.find "attachment", conversation_id: @get("id")

  +computed created_at
  time_from_right_now: ->
    return 0 unless @get "created_at"
    Date.now() - @get "created_at"