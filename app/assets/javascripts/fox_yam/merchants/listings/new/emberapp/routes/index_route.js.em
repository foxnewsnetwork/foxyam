class Foxfire.IndexRoute extends Ember.Route
  renderTemplate: ->
    @render 'fox_yam/merchants/listings/new/emberapp/index'
  setupController: (controller) ->
    controller.set 'model', 
      materials: @store.find 'material'
      locations: @store.find 'location'
      listing_maker: (params) => @store.createRecord('listing', params).validate_and_save()
