class Foxfire.IndexController extends Ember.ObjectController
  quantityUnits: ["pounds", "kilograms", "containers"]
  priceUnits: ["pound", "kilogram", "container"]
  incoterms: ["EXW", "FCA", "FAS", "FOB", "CPT", "CFR", "CIF", "CIP", "DAT", "DAP", "DDP"]
  transportors: ["40ST", "40HC", "45ST", "45HC","20ST","20HC"]
  intervals: ['one-time', 'per week', 'biweek', 'per month', 'per year'] 

  +computed model.listing
  listing: ->
    @model.listing

  listingMaker: ~>
    @model.listing_maker || (k) -> k

  materials: ~>
    @get('model.materials')
 
  locations: ~>
    @get('model.locations')

  +computed selected_files
  pictures: ->
    @get('selected_files')

  +computed pictures
  has_pics: ->
    !Ember.isEmpty @get('pictures')

  +computed locations
  targets: ->
    @get('locations').map (location) ->
      location.target_name = location.location_name
      location

  +computed selected_material, shipping_presentation, price_presentation, quantity_presentation
  email_subject: ->
    @get('quantity_presentation') + " of " + @gay("material") + " " + @get("price_presentation") + " " + @get("shipping_presentation")

  +computed selected_incoterm, selected_location
  shipping_presentation: ->
    [@gay('incoterm'), @gay('location')].join " "

  +computed selected_price, selected_priceunit
  price_presentation: ->
    "$" + @nay('price') + " per " + @gay('priceunit')

  +computed selected_quantity, selected_quantunit, selected_interval
  quantity_presentation: ->
    @nay('quantity') + " " + @gay('quantunit') + " " + @gay('interval')

  +computed email_content
  email_body: ->
    ["Dear all,", @get('email_content')].join('\r\n\r\n')

  +computed email_subject, packing_presentation
  email_content: ->
    @get('email_subject') + " for sale. \r\n\r\n" + @get("packing_presentation") 

  +computed selected_transportor, selected_packweight
  packing_presentation: ->
    @nay("packweight") + " pounds in " + @gay('transportor')

  nay: (key) ->
    v = @get('selected_' + key)
    return v.toLocaleString("en-US") unless Ember.isBlank v
    " __ "

  gay: (key) ->
    v = @get('selected_' + key)
    return v unless Ember.isBlank v
    " __ "

  actions:
    formSubmitted: (params)->
      either = @get("listingMaker")(@listing)
      if either.isLeft()
        @validationErrors = either.error
      if either.isRight()
        