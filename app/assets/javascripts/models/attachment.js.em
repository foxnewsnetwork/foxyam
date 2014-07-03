a = DS.attr
class Foxfire.Attachment extends DS.Model
  conversation_id: a "number"
  +computed conversation_id
  conversation: ->
    @store.find "conversation", @get("conversation_id")

  source: a "string"
  +computed source
  source_name: ->
    _.last "#{@source}".split("/")