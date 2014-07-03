a = DS.attr
class Foxfire.Picture extends DS.Model
  listing_id: a 'number'
  source: a 'string'
  file: a()
  +observer file
  updateSource: ->
    Foxfire.FilePreviewer.generateDataUrl(@file).then (src) => @src = src
  
  +computed file.name
  fileName: ->
    @get "file.name"    