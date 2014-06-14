a = DS.attr
class Foxfire.Listing extends DS.Model
  material_name: a 'string'
  conversation_id: a 'string'
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
  
  validate_and_save: ->
    v = @validate() 
    if v.isValid()
      Foxfire.Either.right @save()
    else
      Foxfire.Either.left v.errors
      
  validate: ->
    Foxfire.ListingValidator.create(listing: @)
      
