class Foxfire.FilesFieldComponent extends Ember.TextField with Foxfire.FileDragDrop
  type: "file"
  multiple: true
  
  didInsertElement: ->
    @bindDragAndDrop()

  willDestroyElement: ->
    @unbindDragAndDrop()

  dragEntered: ->
    @$().removeClass("drag-left").addClass("drag-entered")
    
  dragLeft: ->
    @$().removeClass("drag-entered").addClass("drag-left")

  dragDropped: (files)->
    @handle_files files 
    @dragLeft()

  change: (evt) ->
    @files = evt.target.files
    
  hasFiles: ->
    @files && @files[0]
