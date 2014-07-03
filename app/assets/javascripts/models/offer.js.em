a = DS.attr
class Foxfire.Offer extends DS.Model
  account_id: a "number"
  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  listing_id: a "number"
  +computed listing_id
  listing: ->
    @store.find "listing", @get("listing_id")

  price: a "number"
  +computed price
  rounded_price: ->
    return unless @get 'price'
    @get("price").toPrecision(3)
  incoterm: a "string"
  location: a "string"
  email_content: a "string"
  email_subject: a "string"
  
  +computed id, account_id
  conversations: ->
    @store.find "conversation", 
      offer_id: @get("id")
      account_id: @get("account_id")