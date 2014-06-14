a = DS.attr
class Foxfire.Picture extends DS.Model
  conversation_id: a 'number'
  file: a()
  +observer file
  updateSource: ->
    Foxfire.FilePreviewer.generateDataUrl(@file).then (src) => @src = src