expect = chai.expect

describe Foxfire.PresenceValidator, ->
  specify "should pass", ->
    expect(Foxfire.PresenceValidator).to.be.ok
  context 'shitty data #isValid', ->
    beforeEach ->
      @listing = Ember.Object.create!
      @validator = Foxfire.PresenceValidator.create(subject: @listing, key: "dog", aux: true)
    specify "should not be valid", ->
      expect(@validator.isValid()).to.equal false
    specify "should have the right key", ->
      @validator.isValid()
      expect(@validator.get 'errors.key').to.equal "dog"
    specify "should tell me things are missing", ->
      @validator.isValid()
      expect(@validator.get 'errors.message').to.equal "should be present but was not"
    specify "should have a blank value", ->
      expect(@validator.get 'value').not.to.be.ok
    specify "should not have an error", ->
      expect(@validator.get "errors").not.to.be.ok
  context 'good data #isValid', ->
    beforeEach ->
      @listing = Ember.Object.create(dog: 1)
      @validator = Foxfire.PresenceValidator.create subject: @listing, key: "dog", aux: true
    specify "should be valid", ->
      expect(@validator.isValid!).to.equal true
    specify "should not have any errors", ->
      @validator.isValid!
      expect(@validator.get 'errors').not.to.be.ok

