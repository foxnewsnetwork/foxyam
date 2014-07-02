class Foxfire.Params
  @current-path = -> window.location.hash
  @get = (key) ->
    @window-location-hash![key]
  @window-location-hash = ->
    lexer = new Foxfire.Params.Lexer window.location.hash
    parser = new Foxfire.Params.Parser lexer
    parser.to-hash!

class Foxfire.Params.Lexer
  (@hash-string) ->
    @prepare-hash-string!
    @index = 0
    @tokens = @hash-string.split "/"
  prepare-hash-string: ->
    @hash-string = @hash-string.trim!
    while @peek! is "#" or @peek! is "/"
      @consume!
    @hash-string = _.first @hash-string.split "?"
  peek: ->
    @hash-string.charAt 0
  consume: ->
    a = @peek!
    @hash-string = @hash-string.slice 1
    a


class Foxfire.Params.Parser
  (@lexer) ->
  to-hash: ->
    @reduce-tokens-with-hash (hash, token) ~>
      if @active-key
        hash["#{@active-key}_id"] = token
        @active-key = undefined
      else
        @active-key = token
      hash

  tokens: ->
    @lexer.tokens

  reduce-tokens-with-hash: (reducer) ->
    _.reduce @tokens!, reducer, {}
