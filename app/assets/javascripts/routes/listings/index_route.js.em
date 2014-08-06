class Foxfire.ListingsIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listings/footers/index', outlet: 'footer'
    @render 'listings/headers/index', outlet: 'header'
  setupController: (controller) ->
    controller.set "model", @compositeModel()
  compositeModel: ->
    listings: @fetchListings()
  fetchListings: ->
    @store.find "listing"
    @store.filter "listing", (listing) -> listing.get("id")?