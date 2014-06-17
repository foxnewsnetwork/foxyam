class Foxfire.PictureAdapter extends Foxfire.ApplicationAdapter
  ajaxOptions: (url, type, hash) -> 
    hash = hash || {}
    hash.url = url
    hash.type = type
    hash.dataType = 'json'
    hash.context = @

    if hash.data and type isnt 'GET'
      hash.processData = false
      hash.contentType = false
      hash.data = @packageFormData hash.data

    headers = @get 'headers'
    if headers?
      hash.beforeSend = (xhr) ->
        forEach.call Ember.keys(headers), (key) -> 
          xhr.setRequestHeader key, headers[key]
        
    hash

  packageFormData: (data) ->
    fd = new FormData()
    for key, value of data.picture
      if value instanceof Blob
        fd.append "picture[#{key}]", value, @fetchFilename(value)
      else
        fd.append "picture[#{key}]", value
    fd

  fetchFilename: (file) ->
    return file.name unless Ember.isBlank file.name
    [Math.random().toString().split(".")[1], @fetchFileExt(file)].join "."

  fetchFileExt: (file) ->
    file.type.split("/")[1]