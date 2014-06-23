Foxfire.Router.map ->
  @resource "listings", ->
    @route "new"

  @resource "listing", path: "/listing/:listing_id", ->
    @route "offers"
    @route "docs"

  @resource "fulfilment", path: "/fulfilment/:fulfilment_id", ->
    @route "map"
    @route "discussion"

  @resource "offer", path: "/offer/:offer_id", ->
    @route "counter"
    @route "accept"
    @route "cancel"
    @route "checkout"

  @resource "conversation", path: '/conversation/:conversation_id', ->
    @route "reply"

  @resource "materials", ->
    @route "index"

  @resource "material", path: "/material/:material_id"
  