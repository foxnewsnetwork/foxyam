class Foxfire.PresenceValidator extends Ember.Object with Foxfire.ValidatorBase
  init: ->
    @msg = "should be present but was not"

  validityCheck: ->
    !Ember.isBlank @value
  