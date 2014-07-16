class Foxfire.TagShowController extends Ember.ObjectController
  +computed model
  tag: -> @model

  +computed tag.children.@each
  childTags: ->
    @get("tag.children")

  +computed tag, Foxfire.SelectedTagManager.activeTags.@each
  isChecked: ->
    Foxfire.SelectedTagManager.isTagActive @tag

  actions:
    toggleCheckState: ->
      Foxfire.SelectedTagManager.toggleCheck @get("tag")