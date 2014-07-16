a = DS.attr
class Foxfire.Tag extends DS.Model
  full_name: a "string"
  listing_count: a "number"
  +computed id
  parent: ->
    parents = @store.find "tag", child_id: @get("id")
    return if Ember.isEmpty parents
    parents.get("firstObject")

  +computed id
  children: ->
    @store.find "tag", parent_id: @get("id")

  +computed full_name
  short_name: ->
    _.last @get("full_name").split("+")

  +computed children.@each
  hasChildren: ->
    @get("children.length") > 0

  +computed full_name
  root_name: ->
    _.first @get("full_name").split("+")

  +computed root_name
  prefix: ->
    return "@" if @root_name is "location"
    return "#" if @root_name is "company"
    return "+" if @root_name is "material"
    "*"

