class Foxfire.AttachmentStore
  @flush-store = ->
    files = @files!
    @_internal_store = {}
    files
  @add-file = (file) ->
    key = @generate-unique-key file
    @files![key] = file
    key
  @pop-file = (key) ->
    file = @get-file key
    delete @files![key]
    file
  @get-file = (key) ->
    @files![key]
  @files = ->
    @_internal_store ||= {}
    @_internal_store
  @generate-unique-key = (file) ->
    CryptoJS.MD5 file