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
        done()
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
      @peither = Foxfire.ListingFactory.promise!.then (listing) ->
        listing.validate_and_save!
    specify "saving should result in a right", (done) ->
      @peither.then (either) ->
        expect(either).to.be.ok
        expect(either.isLeft!).to.equal false
        expect(either.isRight!).to.be.ok
        either.payload
      .then (plisting) ->
        console.log plisting
        expect(plisting.get).to.be.a "function"
        expect(plisting.get("conversation_id")).to.be.a "string"
        done!


