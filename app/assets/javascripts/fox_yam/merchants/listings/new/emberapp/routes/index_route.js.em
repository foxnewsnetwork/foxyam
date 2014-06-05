class Foxfire.IndexRoute extends Ember.Route
  renderTemplate: ->
    @render 'fox_yam/merchants/listings/new/emberapp/index'
  setupController: (controller) ->
    controller.set 'model', 
      materials: @store.find 'material'
      locations: @store.find 'location'
