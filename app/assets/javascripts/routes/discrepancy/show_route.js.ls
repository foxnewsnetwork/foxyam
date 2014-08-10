Foxfire.DiscrepancyShowRoute = Ember.Route.extend do
  render-template: ->
    @_super()
    @render 'discrepancy/headers/show', outlet: 'header'
    @render 'discrepancy/footers/show', outlet: 'footer'
