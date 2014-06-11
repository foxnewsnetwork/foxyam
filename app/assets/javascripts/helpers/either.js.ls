class Foxfire.Either
  @left = (error) ->
    new Foxfire.Either(error, null)
  @right = (payload) ->
    new Foxfire.Either(null, payload)
  # This is the monadic >== of Haskell
  # Lefts get skipped
  # Rights get mapped by the bindfn
  # bindfn should be (a -> Either a)
  @bind = (either, bindfn) ->
    return either if either.is-left!
    return bindfn either.payload
  # Haskell's fmap
  # should have type appfn (a -> a)
  @fmap = (either, appfn) ->
    return either if either.is-left!
    return @right appfn either.payload
  # Haskell's <*> for applicative functors
  # Also and instance of Arrow's |||
  @ap = (either, ethfn) ->
    return ethfn.error either.error if ethfn.is-left! && either.is-left!
    return ethfn.payload either.payload if ethfn.is-right! && either.is-right!
    return either
  (@error, @payload) ->

  is-left: ->
    @error?

  is-right: ->
    @payload?