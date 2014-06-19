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
    true || @packing
  hasPlace: ~>
    true || @placeName
  hasQuantity: ~>
    true || @quantity