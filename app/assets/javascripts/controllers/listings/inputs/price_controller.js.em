class Foxfire.ListingsInputsPriceController extends Ember.ObjectController
  incoterms: ["EXW", "FCA", "FAS", "FOB", "CPT", "CFR", "CIF", "CIP", "DAT", "DAP", "DDP"]
  priceUnits: ["pound", "kilogram", "container"]
  locations: ~>
    @store.find "location"