class Foxfire.MaterialsTagsController extends Ember.ObjectController
  +computed model
  roots: ->
    @get("model")

  +computed Foxfire.SessionStore.selectedTags
  selectedTags: ->
    @get("Foxfire.SessionStore.selectedTags")