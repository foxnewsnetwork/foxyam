class Foxfire.IndexRoute extends Ember.Route
  setupController: (controller) ->
    controller.set 'model', @store.find 'material'