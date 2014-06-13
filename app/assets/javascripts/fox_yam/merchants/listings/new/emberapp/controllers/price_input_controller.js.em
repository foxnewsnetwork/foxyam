class Foxfire.PriceInputController extends Ember.ObjectController
  incoterms: ["EXW", "FCA", "FAS", "FOB", "CPT", "CFR", "CIF", "CIP", "DAT", "DAP", "DDP"]
  priceUnits: ["pound", "kilogram", "container"]
  locations: ~> @model
  presentation: ~>
    "$" + @selectedPrice + " per " + @selectedPriceunit + " " + @selectedIncoterm + " - " + @selectedLocation  