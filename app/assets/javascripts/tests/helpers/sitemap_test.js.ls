expect = chai.expect

describe 'Foxfire.Sitemap', ->

  context 'sanity', ->
    specify 'should load properly', ->
      expect(Foxfire.Sitemap).to.be.ok
      expect(Foxfire.Sitemap.instance).to.be.a(Foxfire.Sitemap)