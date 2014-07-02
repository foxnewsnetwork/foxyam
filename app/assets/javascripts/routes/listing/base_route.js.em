class Foxfire.ListingBaseRoute extends Ember.Route with Foxfire.CurrentAccountMixin
  model: (params) ->
    @store.find "listing", params.listing_id  
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'