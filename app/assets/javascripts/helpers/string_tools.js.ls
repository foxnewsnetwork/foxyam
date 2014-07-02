class Foxfire.StringTools
  # Eats away the head of a string given it matches the diet
  # for example:
  # string = "this is a string", diet="this"
  # return = " is a string"
  @eat = (string, diet) ->
    return string if diet is "" || diet is [] || !diet?
    if _.first(string) is _.first(diet)
      @eat _.rest(string).join(""), _.rest(diet)
    else
      string

