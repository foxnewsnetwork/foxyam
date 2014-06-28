class Foxfire.ListingEditRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'listing/footer', outlet: 'footer'
    @render 'listing/headers/edit', outlet: 'header'