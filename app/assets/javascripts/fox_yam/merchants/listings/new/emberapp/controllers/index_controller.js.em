class Foxfire.IndexController extends Ember.ObjectController
  loadingSpecs: ['packing', 'quantity']
  +computed model
  materials: ->
    @get 'model'
  
  
