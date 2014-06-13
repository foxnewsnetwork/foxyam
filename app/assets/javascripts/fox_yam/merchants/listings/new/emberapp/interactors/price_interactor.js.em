class Foxfire.PriceInteractor extends Ember.Object
  presentation: ~>
    "$" + @selectedPrice + " per " + @selectedPriceunit + " " + @selectedIncoterm + " - " + @selectedLocation    
    