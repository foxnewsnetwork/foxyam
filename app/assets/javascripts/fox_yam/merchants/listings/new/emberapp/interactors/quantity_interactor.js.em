class Foxfire.QuantityInteractor extends Ember.Object
  presentation: ~>
    @quantity + " " + @quantityUnit
  quantity: ~>
    return "__" if Ember.isBlank @selectedQuantity
    @selectedQuantity
  quantityUnit: ~>
    return "__" if Ember.isBlank @selectedQuantunit
    @selectedQuantunit