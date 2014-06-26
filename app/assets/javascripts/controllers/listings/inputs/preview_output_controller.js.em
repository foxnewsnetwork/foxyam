class Foxfire.ListingsInputsPreviewOutputController extends Ember.ObjectController
  emailSubject: ~>
    @quantityPresentation + " of " + [@materialPresentation, @pricePresentation].join(" ")
  
  +computed model.selectedMaterial
  materialPresentation: ->
    @get("model.selectedMaterial")

  +computed model.selectedPrice, model.selectedPriceunit, model.selectedIncoterm, model.selectedLocation
  pricePresentation: ->
    pp = _.map ["Price", "Priceunit", "Incoterm", "Location"], (key) =>
      @get "model.selected#{key}"
    "$" + pp.join " "

  +computed model.selectedQuantity, model.selectedQuantunit
  quantityPresentation: ->
    @get("model.selectedQuantity") + " " + @get("model.selectedQuantunit")

  +computed model.selectedPacking, model.selectedTransportor
  packingPresentation: ->
    @get("model.selectedPacking") + " lbs in " + @get("model.selectedTransportor")

  emailBody: ~>
    ["Dear all,", @emailContent, "Sincerely,", "[Your Company]"].join('\r\n\r\n')
  
  emailContent: ~>
    @emailSubject + " for sale. \r\n\r\n" + @packingPresentation
  
  hasPics: ~>
    @selectedFiles

  +computed model.selectedFiles
  selectedFiles: ->
    @get("model.selectedFiles")

  +computed selectedFiles
  pictures: ->
    return [] if Ember.isBlank @get('selectedFiles')
    _.map @get('selectedFiles'), (file) =>
      @store.createRecord 'picture', file: file
  