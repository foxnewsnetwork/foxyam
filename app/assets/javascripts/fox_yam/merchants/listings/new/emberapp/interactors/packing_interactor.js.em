class Foxfire.PackingInteractor extends Ember.Object
  presentation: ~>
    @packingWeight + " pounds in " + @transportor
  packingWeight: ~>
    return "__" if Ember.isBlank @selectedPacking
    @selectedPacking
  transportor: ~>
    return "__" if Ember.isBlank @selectedTransportor
    @selectedTransportor
