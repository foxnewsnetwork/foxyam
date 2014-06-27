class Foxfire.PictureListItemComponent extends Ember.Component
  classNames: ["list-group-item", "completion-bar", "starting", "avatar-dialogue"]
  didInsertElement: ->
    setTimeout _.bind(@loadingAnimation, @), @approximateLoadTime()
  approximateLoadTime: ->
    Math.ceil(250 + 250 * Math.random())
  loadingAnimation: ->
    @$().removeClass "starting"
    @$().addClass "halfway"
  finishAnimation: ->
    @$().removeClass("starting").removeClass("halfway").addClass("completed")
  +computed model.src
  src: ->
    @get("model.src")
  +computed model.fileName
  fileName: ->
    @get("model.fileName")
