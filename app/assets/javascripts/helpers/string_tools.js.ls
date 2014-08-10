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


  @summarize = (string) ->
    Foxfire.StringTools.first-short-sentence(string) or Foxfire.StringTools.first-bunch-of-characters(string)

  @first-short-sentence = (paragraph) ->
    paragraph.split(".")[0] |> (xs) -> xs unless Ember.is-blank(xs) or xs.length > 140

  @first-bunch-of-characters = (paragraph) ->
    paragraph.split("") |> ( (xs) -> _.first xs, 140 ) |> ( .join "" )