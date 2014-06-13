#= require_self
#= require ./store

$('.no-script').hide()

window.Foxfire = Ember.Application.create()

$("footer").hide ->
  setTimeout ->
    $('body').append $('footer').remove()
    $('footer').show()
  , 2000