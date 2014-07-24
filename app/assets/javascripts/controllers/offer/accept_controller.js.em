class Foxfire.OfferAcceptController extends Ember.ObjectController
  actions:
    togglePlanExplanation: ->
      $(".toggle-plan").each (index, el) ->
        el$ = $ el
        if el$.hasClass "hidden"
          el$.removeClass "hidden"
        else
          el$.addClass "hidden"