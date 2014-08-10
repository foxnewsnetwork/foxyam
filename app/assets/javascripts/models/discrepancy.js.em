a = DS.attr
class Foxfire.Discrepancy extends DS.Model
  complaint_party_id: a "string"
  accused_party_id: a "string"
  resolved_at: a "date"
  created_at: a "date"
  fulfilment_id: a "string"
  full_claims: a "string"
  claim_amount: a "number"

  +computed full_claims
  complaint_summary: ->
    Foxfire.StringTools.summarize @full_claims

  +computed fulfilment_id
  fulfilment: -> @store.find "fulfilment", @get("fulfilment_id")

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

  +computed complaint_party_id, accused_party_id, id
  permalink: -> 
    ids = ["complaint_party_id", "id", "accused_party_id"].map (key) => @get key
    "D" + ids.join("-")