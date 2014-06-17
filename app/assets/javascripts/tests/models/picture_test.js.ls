expect = chai.expect

describe Foxfire.Picture, ->
  context 'sanity', ->
    specify "it should be there", ->
      expect(Foxfire.Picture).to.be.ok
    specify "the store should be available", ->
      expect(Foxfire.BaseFactory.store!).to.be.ok
  context 'form submission', ->
    beforeEach ->
      @promise = Foxfire.PictureFactory.promise!

    specify "submission of form-data should upload the file", (done) ->
      @promise.then (picture) ->
        picture.set "conversation_id", 1
        picture.save!
        done!

