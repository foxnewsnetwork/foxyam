class Foxfire.FormForComponent extends Ember.Component
  tagName: 'form'  
  formData: ->
    @$().serializeArray()

  processNewData: ->
    _.partial _.foldl, @formData(), (memo, next) ->
      memo[next.name] = next.value
      memo
  updatedModel: ->
    @processNewData()(@get('model') || {})
  actions:
    reset: ->
      console.log 'reset'
      return true
    submit: ->
      @set 'model', @updatedModel()

