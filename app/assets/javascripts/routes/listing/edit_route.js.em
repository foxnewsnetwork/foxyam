class Foxfire.ListingEditRoute extends Foxfire.ListingBaseRoute
  afterModel: (model, transition) ->
    unless @currentAccountIs model
      @transitionTo "listing.show" model
  renderTemplate: ->
    @_super()
    @render 'listing/headers/edit', outlet: 'header'