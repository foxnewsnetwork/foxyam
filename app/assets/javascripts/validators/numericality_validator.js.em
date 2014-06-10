class Foxfire.NumericalityValidator extends Ember.Object with Foxfire.ValidatorBase
  init: ->
    @msg = "should be greater than " + @greater_than + " but was not" 
  numericality: ~> @aux
  validityCheck: ->
    return true if Ember.isBlank @value
    @value > @greater_than
  +computed numericality.greater_than
  greater_than: ->
    @numericality.greater_than