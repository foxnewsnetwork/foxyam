class Foxfire.HalfModalComponent extends Ember.Component
  classNames: ["half-modal"]
  actions:
    closeModal: ->
      @sendAction()