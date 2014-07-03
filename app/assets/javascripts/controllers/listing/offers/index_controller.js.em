class Foxfire.ListingOffersIndexController extends Foxfire.ListingEditController
  +computed model.offers
  offers: ->
    @get("model.offers")