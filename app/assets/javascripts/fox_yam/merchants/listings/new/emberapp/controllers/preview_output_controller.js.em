class Foxfire.PreviewOutputController extends Ember.ObjectController
  emailSubject: ~>
    @quantityPresentation + " of " + [@materialPresentation, @pricePresentation].join(" ")
  
  materialPresentation: ~>
    @model.materialCtrl.presentation

  pricePresentation: ~>
    @model.priceCtrl.presentation

  quantityPresentation: ~>
    @model.quantityCtrl.presentation

  packingPresentation: ~>
    @model.packingCtrl.presentation

  emailBody: ~>
    ["Dear all,", @emailContent, "Sincerely,", "[Your Company]"].join('\r\n\r\n')
  
  emailContent: ~>
    @emailSubject + " for sale. \r\n\r\n" + @packingPresentation
  
  hasPics: ~>
    @selectedFiles

  selectedFiles: ~>
    @model.picturesCtrl.selectedFiles

  +computed selectedFiles
  pictures: ->
    return [] if Ember.isBlank @get('selectedFiles')
    _.map @get('selectedFiles'), (file) =>
      @store.createRecord 'picture', file: file
  