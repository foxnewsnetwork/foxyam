Foxfire.MaterialsSearchRoute = Ember.Route.extend do
  model: -> @blood-hound()

  render-template: ->
    @_super()
    @render 'materials/headers/search', outlet: 'header'
    @render 'materials/footers/search', outlet: 'footer'

  blood-hound: ->
    @start-puppy!
      ..initialize!

  start-puppy: -> new Bloodhound @blood-options!

  blood-options: ->
    name: 'searches'
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('indicies')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote: @remote-options!
    local: @local-cached-searches!

  local-cached-searches: ->
    @store.all("search") |> @search-to-blood-datums |> _.flatten

  remote-options: ->
    url: "/apiv1/searches.json?q=%QUERY"
    filter: _.bind(@parsed-response-to-blood-search, @)
  
  parsed-response-to-blood-search: (parsed-response)->
    parsed-response |> @parsed-response-to-search |> @search-to-blood-datums

  parsed-response-to-search: (parsed-response) ->
    parsed-response.listings.map (listing) ~> @store.push "listing", listing
    parsed-response.accounts.map (account) ~> @store.push "account", account
    @store.push "search", parsed-response.search

  search-to-blood-datums: (search) ->
    datums = 
      * @listings-to-blood-datums search.get "listings"
        @accounts-to-blood-datums search.get "accounts"
    _.flatten datums

  listings-to-blood-datums: (listings) ->
    return [] unless listings
    listings.map (listing) ->
      type: "listing"
      indicies: [listing.get("material_name"), listing.get("account.company"), listing.get("location_name")].join(" ")
      result: listing
  accounts-to-blood-datums: (accounts) ->
    return [] unless accounts
    accounts.map (account) ->
      type: "account"
      indicies: account.get("company")
      result: account