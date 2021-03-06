#= require_tree ../adapters
#= require_tree ../mixins
#= require_tree ../validators
#= require_tree ../models
#= require_tree ../views
#= require_tree ../helpers
#= require_tree ../components
#= require_tree ../templates

Foxfire.Store = DS.Store.extend
  revision: 12
  adapter: DS.FixtureAdapter.create({ simulateRemoteResponse: true })