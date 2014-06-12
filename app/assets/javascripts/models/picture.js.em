a = DS.attr
class Foxfire.Picture extends DS.Model
  listing: DS.belongsTo('listing')
  file: a()
  +observer file
  updateSource: ->
    Foxfire.FilePreviewer.generateDataUrl(@file).then (src) => @src = src