class Foxfire.QuantityInputController extends Ember.ObjectController
  quantityUnits: ["pounds", "kilograms", "containers"]
  intervals: ['one-time', 'per week', 'biweek', 'per month', 'per year']
  presentation: ~>
    [@selectedInterval, @selectedQuantity, @selectedQuantunit].join " "