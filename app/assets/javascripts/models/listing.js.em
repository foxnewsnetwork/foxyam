a = DS.attr
class Foxfire.Listing extends DS.Model
  account_id: a 'number'
  +computed account_id
  account: ->
    @store.find "account", @get("account_id")
  material_name: a 'string'
  is_private: a 'boolean'
  asking_price: a 'number'
  price_unit: a 'string'
  incoterm: a 'string'
  location_name: a 'string'
  quantity: a 'number'
  quantity_unit: a 'string'
  packing_weight: a 'number'
  transportor: a 'string'
  time_interval: a 'string'
  created_at: a 'date'

  +computed asking_price
  rounded_price: ->
    return unless @asking_price
    @asking_price.toPrecision(3)
    
  +computed id
  offers: ->
    @store.find "offer", listing_id: @get("id")

  +computed id
  pictures: ->
    @store.find "picture", listing_id: @get("id")

  # validate_and_save: ->
  #   v = @validator() 
  #   if v.isValid()
  #     Foxfire.Either.right @saveEverything()
  #   else
  #     Foxfire.Either.left v.errors
  
  # saveEverything: ->
  #   @save().then (listing) =>
  #     @picturePromises listing

  # picturePromises: (listing) ->
  #   promises = _.map @get("pictures"), (picture) ->
  #     picture.conversation_id = listing.conversation_id
  #     picture.save()
  #   Foxfire.PromiseArray.create promises: promises

  # validator: ->
  #   Foxfire.ListingValidator.create(listing: @)
  #     