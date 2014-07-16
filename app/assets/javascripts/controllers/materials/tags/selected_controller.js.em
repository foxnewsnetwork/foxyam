class Foxfire.MaterialsTagsSelectedController extends Ember.ObjectController
  +computed tags.@each.listing_count
  resultsCount: ->
    return "∞" if @tags.get("length") < 1
    add = (a,b) -> a + b
    pluck = (tag) -> tag.get("listing_count")
    @tags.map(pluck).reduce add, 0

  +computed Foxfire.SelectedTagManager.activeTags.@each
  tags: ->
    Foxfire.SelectedTagManager.activeTags

  +computed tags.@each.prefix, tags.@each.short_name
  tagsQuerystring: ->
    return "" if @tags.get("length") < 1
    add = (a,b) -> a + encodeURIComponent(b.get("prefix") + b.get("short_name"))
    @tags.reduce add, ""

  actions:
    clearAllTags: ->
      Foxfire.SelectedTagManager.killEverything()