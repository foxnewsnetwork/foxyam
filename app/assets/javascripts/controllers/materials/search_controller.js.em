class Foxfire.MaterialsSearchController extends Ember.ObjectController
  queryParams: ["q"]
  q: null
  +computed model
  bloodhound: -> @get("model")

  +computed bloodpact
  searchResults: ->
    DS.PromiseArray.create promise: @bloodpact

  +computed searchResults.@each.type
  listings: ->
    rs = @searchResults.filter (result) ->
      result.type is "listing"
    rs.map (r) -> r.result

  +computed searchResults.@each.type
  accounts: ->
    rs = @searchResults.filter (result) ->
      result.type is "account"
    rs.map (r) -> r.result

  +computed decodedQuerystring, bloodhound
  bloodpact: ->
    new Ember.RSVP.Promise (resolve) =>
      return resolve [] unless @decodedQuerystring
      @bloodhound.get @decodedQuerystring, (bloodata) -> resolve bloodata
  
  +computed q
  decodedQuerystring: ->
    decodeURIComponent(@q) or ""

  +computed listings.@each.material.hasGraph
  materials: ->
    @get("listings").filter (listing) ->
      listing.get("material.hasGraph")

  +computed decodedQuerystring
  material: ->
    @store.find("material", @decodedQuerystring)

  +computed material.hasGraph
  hasDataPlot: ->
    @get("material.hasGraph")

  +computed listings
  hasListings: ->
    not Ember.isBlank @listings

  +computed accounts
  hasAccounts: ->
    not Ember.isBlank @accounts

  +computed haveNotSearchedYet
  hasAlreadySearched: ->
    not @haveNotSearchedYet

  +computed hasAlreadySearched, hasListings, hasAccounts
  searchedButNoResults: ->
    @hasAlreadySearched and not (@hasListings or @hasAccounts)
    
  +computed decodedQuerystring
  haveNotSearchedYet: ->
    Ember.isBlank @decodedQuerystring