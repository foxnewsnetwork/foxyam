class Foxfire.PictureListItemComponent extends Ember.Component
  classNames: ["list-group-item", "completion-bar", "starting"]
  didInsertElement: ->
    setTimeout _.bind(@loadingAnimation, @), 400
  loadingAnimation: ->
    @$().removeClass "starting"
    @$().addClass "halfway"
  finishAnimation: ->
    @$().removeClass("starting").removeClass("halfway").addClass("completed")
  src: ~>
    @model.src
