class Foxfire.ListingsNewController extends Ember.ObjectController
  listing: ~> @model
  actions:
    showEdit: ->
      $(".display-frame").removeClass("display-frame-side")
    showPreview: ->
      $(".display-frame").addClass("display-frame-side")
      window.scrollTo 0, 0