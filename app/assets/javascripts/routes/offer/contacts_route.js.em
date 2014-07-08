class Foxfire.OfferContactsRoute extends Ember.Route
  renderTemplate: ->
    @_super()
    @render 'offer/headers/contacts', outlet: 'header'
    @render 'offer/footers/contacts', outlet: 'footer'