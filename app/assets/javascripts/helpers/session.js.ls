class Foxfire.Session
  @current-user = null
  @user-logged-in = ->
    @current-user?