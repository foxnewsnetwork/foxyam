#= require ../../../shared/bootstrapper
#= require_tree ../../../tests
#= require_tree ./controllers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self
mocha.checkLeaks()
mocha.globals(['jQuery', '_', 'Ember', 'Foxfire'])
mocha.run()