class Foxfire.ListingsSummariesTitleController extends Ember.ObjectController
  material: ~>
    @model.material_name
  placeName: ~>
    @model.place_name
  quantity: ~>
    @model.quantity
  units: ~>
    @model.quantity_unit
  packing: ~>
    @model.packing
  packingUnits: ~>
    @model.packing_units
  hasPacking: ~>
    @packing
  hasPlace: ~>
    @placeName
  hasQuantity: ~>
    @quantity