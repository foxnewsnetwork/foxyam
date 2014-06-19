Foxfire.Router.map ->
  @resource "listings", ->
    @route "new"

  @resource "listing", path: "/listing/:listing_id"

  @resource "materials", ->
    @route "index"

  @resource "material", path: "/material/:material_id"
  