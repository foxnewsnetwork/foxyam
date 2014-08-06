class Foxfire.MaterialsSearchController extends Ember.ObjectController
  queryParams: ["q"]
  q: null
  +computed model
  bloodhound: -> @get("model")

  +computed bloodpact
  listings: ->
    DS.PromiseArray.create promise: @bloodpact

  +computed decodedQuerystring, bloodhound
  bloodpact: ->
    new Ember.RSVP.Promise (resolve) =>
      return resolve [] unless @decodedQuerystring
      @bloodhound.get @decodedQuerystring, (bloodlistings) ->
        resolve _.pluck bloodlistings, "listing"
  
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