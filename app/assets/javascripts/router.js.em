Foxfire.Router.map ->
  @resource 'listings', ->
    @route 'new'
    @route 'preview'

  @resource 'listing', path: '/listing', ->
    @route 'show', path: '/:listing_id'
    @route 'edit', path: '/:listing_id/edit'
    @resource 'listing.offers', path: '/:listing_id/offers', ->
      @route 'new'

  @resource 'fulfilment', path: '/fulfilment/:fulfilment_id', ->
    @route 'now'
    @route 'log'

  @resource 'offer', path: '/offer/:offer_id', ->
    @route 'counter'
    @route 'accept'
    @route 'cancel'
    @route 'checkout'

  @resource 'conversation', path: '/conversation/:conversation_id', ->
    @route 'reply'

  @resource 'materials', ->
    @route 'index'

  @resource 'material', path: '/material/:material_id'
  
  @resource 'session', ->
    @route 'new'

  @resource 'account', path: '/account/:account_id', ->
    @route 'purchases'
    @route 'sells'

  @resource 'login'
  @resource 'register'
  @resource 'help'