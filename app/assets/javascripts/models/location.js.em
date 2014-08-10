a = DS.attr
class Foxfire.Location extends DS.Model
  location_name: a "string"
  permalink: a "string"
  address1: a "string"
  address2: a "string"
  city: a "string"
  state: a "string"
  country: a "string"
  confirmed_at: a "date"
  
  +computed confirmed_at
  hasBeenConfirmed: ->
    @confirmed_at
