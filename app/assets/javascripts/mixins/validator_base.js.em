mixin Foxfire.ValidatorBase
  isValid: ->
    if @validityCheck()
      true
    else
      @addError @key, @msg
  addError: (key, msg) ->
    @errors = new Ember.Object() unless @errors
    @errors.key = key
    @errors.message = msg
    false
  +computed subject, key
  value: ->
    @subject.get @key