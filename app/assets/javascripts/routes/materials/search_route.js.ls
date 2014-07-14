Foxfire.MaterialsSearchRoute = Ember.Route.extend do
  model: -> @bloodHound()
  renderTemplate: ->
    @_super()
    @render 'materials/headers/search', outlet: 'header'
    @render 'materials/footers/search', outlet: 'footer'
  listings: ->
    @store.find("listing")
  listingsForBloodhound: ->
    @listings!.map @listing2Bloodhound
  listing2Bloodhound: (listing) ->
    value: listing.get("material_name")
    listing: listing
  remoteOptions: ->
    url: "/apiv1/listings.json?q=%QUERY"
    filter: _.bind(@parsedResponse2BloodhoundListing, @)
  parsedResponse2BloodhoundListing: (parsedResponse) ->
    @parsedResponse2Listings(parsedResponse).map @listing2Bloodhound
  parsedResponse2Listings: (parsed-response) ->
    parsed-response.listings.map (listing-data) ~>
      @store.push "listing", listing-data
  bloodHound: ->
    dog = @start-puppy!
    dog.initialize!
    dog
  start-puppy: ->
    new Bloodhound @blood-options!
  blood-options: ->
    name: "listings"
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote: @remoteOptions()
    local: @listingsForBloodhound()
