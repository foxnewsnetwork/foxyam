class Foxfire.FormForComponent extends Ember.Component
  tagName: 'form'  
  formData: ->
    @$().serializeArray()

  processNewData: ->
    _.partial _.foldl, @formData(), (memo, next) ->
      memo.set next.name, next.value
      memo
  updatedModel: ->
    @processNewData()(@model || new Ember.Object())
  
  +observer errors
  displayErrors: ->
    @resetErrorFields()
    @highlightErrorFields()
    @explainErrorFields()

  resetErrorFields: ->
    @$("input").removeClass "input-with-error"
    @$("input").tooltip "destroy"

  explainErrorFields: ->
    _.map @errors, (error) =>
      @$("input[name=#{error.get 'key'}]").tooltip
        title: error.get "message"
        trigger: 'hover focus'
  highlightErrorFields: ->
    _.map @nameWithErrors, (name) =>
      @$("input[name=#{name}]").addClass "input-with-error"

  +computed errors
  nameWithErrors: ->
    _.map @errors, (error) ->
      error.get 'key'

  actions:
    submit: ->
      @sendAction "action", @updatedModel()