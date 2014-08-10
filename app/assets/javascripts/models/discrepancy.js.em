a = DS.attr
class Foxfire.Discrepancy extends DS.Model
  complaint_party_id: a "string"
  accused_party_id: a "string"
  complaint_summary: a "string"
  resolved_at: a "date"
  created_at: a "date"

  +computed complaint_party_id
  complaintParty: -> @store.find "account", @get("complaint_party_id")

  +computed accused_party_id
  accusedParty: -> @store.find "account", @get("accused_party_id")

  +computed resolved_at
  hasBeenResolved: ->
    @get("resolved_at")

  +computed created_at
  timeSinceFiling: ->
    $.timeago @get("created_at")
