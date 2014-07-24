a = DS.attr
class Foxfire.Service extends DS.Model
  offer_id: a "string"
  account_id: a "string"
  name: a "string"
  accepted: a "boolean"

  +computed offer_id
  offer: -> @store.find "offer", @offer_id