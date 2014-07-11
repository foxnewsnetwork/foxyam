class Foxfire.Sitemap
  @draw = (func) ->
    @instance = new Foxfire.Sitemap func
  @direction-from = (origin) ->
    { to: (target) ~> @instance.calculate-direction origin, target }
  @direction-from-our-current-route-to = (route-name) ->
    origin = Foxfire.Router.router.currentRouteName!
    target = route-name
    @direction-from(origin).to(target)
  @opposite-direction = (direction) ->
    switch direction
    case "east" then "west"
    case "west" then "east"
    case "south" then "north"
    case "north" then "south"
    default direction
  (func) -> 
    @flat-tree = {}
    helper = new Foxfire.Sitemap.DSLHelper(func)
    helper.setup @
  _calculate-direction: (origin, target) ->
    hash = @flat-tree[origin] || {}
    switch
    case _.contains hash.east, target then "east"
    case _.contains hash.west, target then "west"
    case _.contains hash.south, target then "south"
    case _.contains hash.north, target then "north"
    default void
  calculate-direction: (origin, target) ->
    @_calculate-direction(origin, target) || @@opposite-direction @_calculate-direction(target, origin) || "teleport"
  mark-route: (origin-route, direction, target-route) ->
    @flat-tree[origin-route] ||= {}
    @flat-tree[origin-route][direction] ||= [] 
    @flat-tree[origin-route][direction].unshift target-route

class Foxfire.Sitemap.DSLHelper
  (@draw-func) ->
  setup: (sitemap) ->
    @sitemap = sitemap
    @draw-func.apply @
  route: (origin-route) ->
    you-find: (target-route) ~>
      to-the-east: ~>
        @sitemap.mark-route origin-route, "east", target-route
      to-the-west: ~>
        @sitemap.mark-route origin-route, "west", target-route
      to-the-south: ~>
        @sitemap.mark-route origin-route, "south", target-route
      to-the-north: ~>
        @sitemap.mark-route origin-route, "north", target-route
    