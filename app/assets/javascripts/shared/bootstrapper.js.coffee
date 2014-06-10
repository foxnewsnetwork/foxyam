#= require_self
#= require ./store

$('.no-script').hide()
window.Foxfire = Ember.Application.create()
$(document).ready ->
  $('body').append $('footer').remove()