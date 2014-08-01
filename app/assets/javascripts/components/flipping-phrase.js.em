class Foxfire.FlippingPhraseComponent extends Ember.Component
  classNames: ['flipping-phrase']
  endAnime: 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'

  didInsertElement: ->
    @updateText()
    @interval = @cycleThroughPhrases()

  willDestroyElement: ->
    @_super()
    clearInterval @interval

  cycleThroughPhrases: ->
    @cyclingFunction()(5000)

  cyclingFunction: ->
    _.partial setInterval, =>
      @animatePhraseChange()

  animatePhraseChange: ->
    @animateOut =>
      @updateText =>
        @animateIn

  animateOut: (cb) ->
    @$('.flip-phrase').addClass("animated zoomOut").one @endAnime, ->
      $(@).removeClass("animated zoomOut") and cb()

  updateText: (cb) ->
    @activePhrase = @phraseArray[@activeIndex()] or "loading catch phrases"
    cb() if cb

  activeIndex: ->
    @active_index = -1 if Ember.isBlank(@active_index) or @active_index >= @get("phrases.length")
    @active_index = @active_index + 1
    @active_index

  +computed phrases.@each
  phraseArray: ->
    @get("phrases") or []


  animateIn: ->
    @$('.flip-phrase').addClass("animated zoomIn").one @endAnime, ->
      $(@).removeClass "animated zoomIn"