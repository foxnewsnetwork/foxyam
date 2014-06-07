class Foxfire.FilesFieldComponent extends Ember.TextField with Foxfire.FileDragDrop
  type: "file"
  multiple: true
  
  didInsertElement: ->
    @bindDragAndDrop()

  willDestroyElement: ->
    @unbindDragAndDrop()

  dragEntered: ->
    @$().css "border", "4px dashed #2b669a"
    @$().css "height", "75px"

  dragLeft: ->
    @$().css "border", "none"
    @$().css "height", "55px"

  dragDropped: (files)->
    @handle_files files 
    @dragLeft()

  change: (evt) ->
    files = evt.target.files
    @handle_files files if files && files[0]

  handle_files: (files) ->
    @read_the_files(files).map (file_promise) =>
      file_promise.then (file) =>
        @push_file file

  push_file: (file) ->
    @set "files", @pushA("files", file)

  pushA: (key, thing) ->
    things = @getA(key)
    things.push thing
    things

  getA: (key) ->
    a = @get key
    @set key, [] if Ember.isEmpty a
    a || []

  read_the_files: (files) ->
    _.map files, (file) => 
      @promise_to_read file

  promise_to_read: (file) ->
    new Ember.RSVP.Promise (resolve) =>
      @resolution_file_reader(resolve).readAsDataURL file
      
  resolution_file_reader: (resolve) ->
    r = new FileReader()
    r.onloadend = (e) ->
      resolve e.target.result
    r
