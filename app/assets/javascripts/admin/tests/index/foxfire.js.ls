#= require ../../../shared/bootstrapper
#= require ../../../shared/test_store
#= require_tree ../../../tests
#= require_tree ./controllers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self
mocha.checkLeaks!
mocha.globals ['jQuery', '_', 'Ember', 'Foxfire']
Foxfire.setupForTesting!
Foxfire.injectTestHelpers!
mocha.run!