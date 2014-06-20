class Foxfire.ListingIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'