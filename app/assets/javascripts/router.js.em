Foxfire.Router.map ->
  @resource "listings", ->
    @route "new"

  @resource "listing", path: "/listing/:listing_id", ->
    @route "offers"
    @route "docs"

  @resource "offer", path: "/offer/:offer_id", ->
    @route "counter"
    @route "accept"
    @route "cancel"

  @resource "conversation", path: '/conversation/:conversation_id', ->
    @route "reply"

  @resource "materials", ->
    @route "index"

  @resource "material", path: "/material/:material_id"
  