expect = chai.expect

describe "Foxfire.ListingValidator", ->
  specify "should be loaded", -> expect(Foxfire.ListingValidator).to.be.ok
  context 'good data', ->
    beforeEach ->
      @listing = Foxfire.ListingFactory.mock!
      @listing.pictures = ["dogs"]
      @validator = Foxfire.ListingValidator.create listing: @listing
    specify 'should have registered the listing', ->
      expect(@validator.get 'listing').to.be.ok
    specify 'factory produced listing', ->
      expect(@listing.get "material_name").to.be.ok
      expect(@listing.get "is_private").to.equal false
      expect(@listing.get "asking_price").to.be.ok
      expect(@listing.get "price_unit").to.be.ok
      expect(@listing.get "incoterm").to.be.ok
      expect(@listing.get "location_name").to.be.ok
      expect(@listing.get "quantity").to.be.ok
      expect(@listing.get "quantity_unit").to.be.ok
      expect(@listing.get "packing_weight").to.be.ok
      expect(@listing.get "transportor").to.be.ok
      expect(@listing.get "time_interval").to.be.ok
    specify "should have validators", ->
      expect(@validator.get 'validators').to.be.ok
    specify "should be valid", ->
      expect(@validator.isValid!).to.equal true
    specify "should not have errors", ->
      @validator.isValid()
      expect(@validator.get 'errors').not.to.be.ok
  context 'bad data', ->
    beforeEach ->
      @listing = Ember.Object.create(time_interval: "never", transportor: "Jason Stanthem")
      @validator = Foxfire.ListingValidator.create listing: @listing
    specify "should not be valid", ->
      expect(@validator.isValid!).to.equal false
    specify "should have a bunch of validators", ->
      expect(@validator.get 'validators').to.be.ok
      expect(@validator.get 'validators').to.have.length 16
    specify 'should have registered the listing', ->
      expect(@validator.get 'listing').to.be.ok
    specify 'should have errors', ->
      @validator.isValid!
      expect(@validator.get 'errors').to.have.length 9