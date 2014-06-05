class Foxfire.TypeAheadComponent extends Ember.TextField
  typeahead_opts:
    hint: true
    highlight: true
    minLength: 1
  didInsertElement: ->
    @_super()
    if $.isFunction @get("data").then
      @get("data").then (data) => @initializeTypeahead data
    else
      @initializeTypeahead @get "data"

  bloodhound_source: (data)->
    b = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
      queryTokenizer: Bloodhound.tokenizers.whitespace
      local: data.map (item) => 
        {
          value: item.get(@get("name"))
          name: item.get(@get("name"))
          presentation: item.get('presentation') || item.get(@get("name"))
          emberObject: item
        }
    b.initialize()
    b

  initializeTypeahead: (data) ->
    @typeahead = @$().typeahead @typeahead_opts, @generate_typeahead_params data
    @typeahead.on "typeahead:selected", (e, item) => 
      @set "selection", item.emberObject
    @typeahead.on "typeahead:autocompleted", (e, item) => @set "selection", item.emberObject
    if @get "selection"
      @typeahead.val @get "selection.name"

  generate_typeahead_params: (data) ->
    name: @$().attr('id') || "typeahead"
    limit: @get("limit") || 5
    displayKey: "value"
    source: @bloodhound_source(data).ttAdapter()

  +observer selection
  selectionObserver: ->
    if Ember.isEmpty @get 'selection'
      @typeahead.val('')
    else
      s = @get("selection").get @get "name"
      @typeahead.val s
    
