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
  # pictures: ->
  #   # To Be Implemented
  