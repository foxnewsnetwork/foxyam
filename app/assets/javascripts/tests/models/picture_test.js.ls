expect = chai.expect

describe Foxfire.Picture, ->
  specify "it should be there", ->
    expect(Foxfire.Picture).to.be.ok
  specify "the store should be available", ->
    expect(Foxfire.BaseFactory.store!).to.be.ok
  