a = DS.attr
class Foxfire.Account extends DS.Model
  company: a "string"
  email: a "string"
  password: a "string"
  passwordConfirmation: a "string"
  image: a "string"

  +computed id
  fulfilments: -> @store.find "fulfilment", account_id: @get("id")

  +computed id
  listings: -> @store.find "listing", account_id: @get("id")

  +computed id
  offers: -> @store.find "offer", account_id: @get("id")