class Foxfire.ContactShowRoute extends Ember.Route 
  renderTemplate: ->
    @_super()
    @render 'contact/footers/show', outlet: 'footer'
    @render 'contact/headers/show', outlet: 'header'