class Foxfire.TemplateInitializer
  @already-run = false
  @run-once = ->
    return if @already-run
    _.each Ember.Templates, (func, key) ->
      console.log "Unretardifying templates"
      Ember.Templates[_.last(key.split("/"))] = func if _.first(key.split("/")) is "fox_yam"
    @already-run = true