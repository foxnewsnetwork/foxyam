Foxfire.Router.map ->
  @resource 'contact', path: '/contact', ->
    @route 'show', path: '/:contact_id'

  @resource 'listings', ->
    @route 'new'
    @route 'preview'

  @resource 'listing', path: '/listing', ->
    @route 'show', path: '/:listing_id'
    @route 'edit', path: '/:listing_id/edit'
    @resource 'listing.offers', path: "/:listing_id/offers", ->
      @route 'new'

  @resource 'fulfilment', path: '/fulfilment/:fulfilment_id', ->
    @route 'now'
    @route 'log'

  @resource 'offer', path: '/offer', ->
    @route 'show', path: '/:offer_id'
    @route 'counter', path: '/:offer_id/counter'
    @route 'accept', path: '/:offer_id/accept'
    @route 'cancel', path: '/:offer_id/cancel'
    @route 'checkout', path: '/:offer_id/checkout'
    @route 'contacts', path: '/:offer_id/contacts'

  @resource 'conversation', path: '/conversation/:conversation_id', ->
    @route 'reply'

  @resource 'materials', ->
    @route 'index'
    @route 'search'
    @route 'tags'

  @resource "tag", path: "/tag/:tag_id", ->
    @route "show"

  @resource 'material', path: '/material/:material_id'
  
  @resource 'session', ->
    @route 'new'

  @resource 'account', path: '/account/:account_id', ->
    @route 'show'
    @route 'purchases'
    @route 'sells'
    @route 'preferences'

  @resource 'sessions', path: '/sessions', ->
    @route 'new'

  @resource 'registrations', path: '/registrations', ->
    @route 'new'
    
  @resource 'help'

Foxfire.Router.router.generateFromIntent = (intent) ->
  state = intent.applyToState(@state, @recognizer, @getHandler)
  params = {}

  for handlerInfo in state.handlerInfos
    handlerParams = handlerInfo.serialize()
    $.extend params, handlerParams
  params.queryParams = intent.queryParams

  @recognizer.generate intent.name, params

Foxfire.Router.router.currentRouteName = ->
  @state.handlerInfos.get("lastObject.name")