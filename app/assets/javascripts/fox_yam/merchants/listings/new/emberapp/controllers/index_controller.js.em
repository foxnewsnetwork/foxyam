class Foxfire.IndexController extends Ember.ObjectController
  quantityUnits: ["pounds", "kilograms", "containers"]
  priceUnits: ["pound", "kilogram", "container"]
  incoterms: ["EXW", "FCA", "FAS", "FOB", "CPT", "CFR", "CIF", "CIP", "DAT", "DAP", "DDP"]
  transportors: ["40ST", "40HC", "45ST", "45HC","20ST","20HC"]
  intervals: ['one-time', 'per week', 'biweek', 'per month', 'per year']
  +observer listing
  updateListing: ->
    @get('listing_maker') @get 'listing' if @get('listing')?

  +computed model.listing_maker
  listing_maker: ->
    @get 'model.listing_maker'

  +computed model.materials
  materials: ->
    @get('model.materials')

  
  +computed model.locations
  locations: ->
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
    ["Dear all,", @get('email_content')].join('\r\n')

  +computed email_subject, packing_presentation
  email_content: ->
    @get('email_subject') + " for sale. \r\n" + @get("packing_presentation") 

  +computed selected_transportor, selected_packweight
  packing_presentation: ->
    @nay("packweight") + " pounds in " + @gay('transportor')

  nay: (key) ->
    v = @get('selected_' + key)
    return v.toLocaleString("en-US") if v?
    " __ "

  gay: (key) ->
    v = @get('selected_' + key)
    return v if v?
    " __ "

  