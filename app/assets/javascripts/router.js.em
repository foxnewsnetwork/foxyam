Foxfire.Router.map ->
  @resource "listings", ->
    @route "new"

  @resource "listing", path: "/listing/:listing_id", ->
    @route "offers"

  @resource "offer", path: "/offer/:offer_id"

  @resource "materials", ->
    @route "index"

  @resource "material", path: "/material/:material_id"
  