a = DS.attr
class Foxfire.Offer extends DS.Model
  account_id: a "number"
  listing_id: a "number"
  fulfilment_id: a "number"
  price: a "number"
  incoterm: a "string"
  location: a "string"
  email_content: a "string"
  email_subject: a "string"

  +computed fulfilment_id, account_id
  fulfilment: ->
    @store.find "fulfilment", @get("fulfilment_id"), account_id: @get("account_id")

  +computed account_id
  account: ->
    @store.find "account", @get("account_id")

  +computed listing_id
  listing: ->
    @store.find "listing", @get("listing_id")

  +computed price
  rounded_price: ->
    return unless @get 'price'
    @get("price").toPrecision(3)
  
  +computed id, account_id
  conversations: ->
    @store.find "conversation", 
      offer_id: @get("id")
      account_id: @get("account_id")

  +computed id, account_id
  unread_conversations: ->
    []