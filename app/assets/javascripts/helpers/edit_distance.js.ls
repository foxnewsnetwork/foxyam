class Foxfire.EditDistanceFunction
  @calculate = (worda, wordb) ->
    return Foxfire.EditDistanceFunction.calculate(worda.split(""), wordb) if worda instanceof String 
    return Foxfire.EditDistanceFunction.calculate(worda, wordb.split("")) if wordb instanceof String 
    return worda.length if wordb.length is 0
    return wordb.length if worda.length is 0
    both = -> Foxfire.EditDistanceFunction.calculate worda.slice(1), wordb.slice(1)
    left = -> Foxfire.EditDistanceFunction.calculate(worda.slice(1), wordb)
    right = -> Foxfire.EditDistanceFunction.calculate(worda, wordb.slice(1))
    return both() if worda[0] is wordb[0]
    return 1 + Math.min left(), right(), both()