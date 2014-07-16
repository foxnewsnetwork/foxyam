class Foxfire.TagShowSliceController extends Ember.ObjectController
  +computed model
  tag: -> @model

  +computed tag.hasChildren
  hasChildren: ->
    @get("tag.hasChildren")

  +computed hasChildren
  barrenOfChild: ->
    !@hasChildren

  +computed tag, Foxfire.SelectedTagManager.activeTags.@each
  isChecked: ->
    Foxfire.SelectedTagManager.isTagActive @tag

  actions:
    toggleCheckState: ->
      Foxfire.SelectedTagManager.toggleCheck @get("tag")
