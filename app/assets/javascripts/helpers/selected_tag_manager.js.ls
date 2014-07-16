Foxfire.SelectedTagManager = new Ember.Object!
stm = Foxfire.SelectedTagManager

Foxfire.SelectedTagManager.active-tags = Ember.ArrayProxy.create content: Ember.A([])

Foxfire.SelectedTagManager.toggle-check = (tag) ->
  if stm.has-tag tag
    stm.remove-tag tag
  else
    stm.add-tag tag

Foxfire.SelectedTagManager.kill-everything = ->
  stm.active-tags.clear()

Foxfire.SelectedTagManager.remove-tag = (tag) ->
  return tag unless stm.get-id tag
  return tag unless stm.has-tag tag
  result = stm.active-tags.find (tag2, index) ->
    id1 = stm.get-id tag
    id2 = stm.get-id tag2
    if id1 and id1 is id2
      stm.active-tags.remove-at index
      true

Foxfire.SelectedTagManager.add-tag = (tag) ->
  return tag unless stm.get-id tag
  return tag if stm.has-tag tag
  stm.active-tags.push-object tag

Foxfire.SelectedTagManager.has-tag = (tag) ->
  stm.active-tags.find (tag2) ->
    id1 = stm.get-id tag
    id2 = stm.get-id tag2
    id1 and id1 is id2

Foxfire.SelectedTagManager.is-tag-active = Foxfire.SelectedTagManager.has-tag

Foxfire.SelectedTagManager.get-id = (tag) ->
  return tag.get("id") if tag instanceof Ember.Object
  return tag.id if tag instanceof Object

  