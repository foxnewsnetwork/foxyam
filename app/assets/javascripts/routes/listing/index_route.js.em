class Foxfire.ListingIndexRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/header', outlet: 'header'