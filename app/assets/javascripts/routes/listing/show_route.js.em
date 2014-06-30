class Foxfire.ListingShowRoute extends Ember.Route
  model: (params) ->
    @store.find "listing", params.listing_id
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/headers/index', outlet: 'header'