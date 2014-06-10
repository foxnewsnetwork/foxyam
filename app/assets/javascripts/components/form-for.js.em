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
    submit: ->
      @set 'model', @updatedModel()

