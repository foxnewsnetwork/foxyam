class Foxfire.StepShowLogsController extends Ember.ObjectController
  +computed model
  step: -> @model

  +computed conversations
  hasConversations: ->
    !Ember.isEmpty @get("conversations")

  +computed step.conversations.@each
  conversations: ->
    return [] unless @get("step.conversations")
    @get("step.conversations").sortBy "time_from_right_now"