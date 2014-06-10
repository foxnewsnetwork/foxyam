class Foxfire.InclusionValidator extends Ember.Object with Foxfire.ValidatorBase
  init: ->
    @msg = "#{@value} should be a member of #{@inclusions} but is not"
  inclusions: ~> @aux
  validityCheck: ->
    return true if Ember.isBlank @value
    !Ember.isBlank _.find @inclusions, (thing) => thing is @value