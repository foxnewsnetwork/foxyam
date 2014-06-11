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
    throw "You need to specify a subject" unless @subject
    throw "You need to specify a field to validate" unless @key
    @subject.get @key