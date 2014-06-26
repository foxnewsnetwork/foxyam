class Foxfire.ListingsInputsMaterialController extends Ember.ObjectController
  materials: ~>
    @store.find "material"
