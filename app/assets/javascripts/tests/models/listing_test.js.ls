expect = chai.expect

describe "Foxfire.Listing", ->
  context 'factory', ->
    beforeEach ->
      @listing = new Ember.RSVP.Promise (resolve) ->
        Ember.run -> resolve Foxfire.BaseFactory.store!.createRecord('listing', {})
    specify "should be able to access the store", ->
      expect(Foxfire.BaseFactory.store!).to.be.ok
    specify "should have the have createRecord function", ->
      expect(Foxfire.BaseFactory.store!.createRecord).to.be.a "function"
    specify "should create a listing", (done) ->
      @listing.then (listing) ->
        expect(listing).to.be.ok
        expect(listing.validate_and_save).to.be.a "function"
        done!
  context 'shitty validation', ->
    beforeEach ->
      @promise = new Ember.RSVP.Promise (resolve) ->
        Ember.run -> resolve Foxfire.BaseFactory.store!.createRecord('listing', {}).validate_and_save!
    specify "should be alright", (done) ->
      @promise.then (either) ->
        expect(either).to.be.ok
        expect(either.isLeft).to.be.a "function"
        expect(either.isLeft!).to.be.ok
        expect(either.isRight!).not.to.ok
        done!
  context "good validation", ->
    before ->
      @listingPromise = Foxfire.ListingFactory.promise!
      @picturePromise = Foxfire.PictureFactory.promise!
      @par1 = Foxfire.PromiseArray.create promises: [@listingPromise, @picturePromise]
      @par2 = @par1.then ([listing, picture]) ->
        listing.pictures = [picture]
        listing
    
    specify "the listing should be held in the promise array", (done) ->
      @par2.then (listing) ->
        expect(listing).to.be.ok
        expect(listing.get "material_name").to.be.a "string"
        expect(listing.get "asking_price").to.equal 0.35
        expect(listing.get "incoterm").to.equal "FAS"
        done!

    specify "the listing should have an array of pictures", (done) ->
      @par2.then (listing) ->
        expect(listing).to.have.property "pictures"
        expect(listing.pictures).to.be.a "array"
        expect(listing.pictures).to.have.length 1
        done!

    specify.skip "saving the listing should result in the pictures and listing being saved", (done) ->
      @par2.then (listing) ->
        listing.validate_and_save()
      .then (either) ->
        expect(either).to.have.property("isRight")
        expect(either.isRight!).to.equal true
        either.payload
      .then (listing) ->
        console.log listing
        done!