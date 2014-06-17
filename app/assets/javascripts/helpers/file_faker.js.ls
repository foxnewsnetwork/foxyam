class Foxfire.FileFaker
  @image = ->
    @to-blob @abstract-art-canvas()

  @to-blob = (canvas) ->
    parts = canvas.toDataURL!.match /data:([^;]*)(;base64)?,([0-9A-Za-z+\/]+)/
    binStr = atob parts[3]
    buf = new ArrayBuffer binStr.length
    view = new Uint8Array buf
    for i from 0 to view.length by 1
      view[i] = binStr.charCodeAt(i)
    
    new Blob [view], type: parts[1]

  @abstract-art-canvas = ->
    c = @blank-canvas!
    @draw-randomly c
    c

  @draw-randomly = (canvas) ->
    ctx = canvas.getContext "2d"
    ctx.beginPath!
    ctx.arc(95,50,40,0,2*Math.PI)
    ctx.stroke!
    ctx.font = "30px Arial"
    ctx.strokeText "Hello World",10,50

  @blank-canvas = ->
    canvas$ = $ "<canvas></canvas>", @canvas-attr!
    canvas$[0]
  
  @canvas-attr = ->
    width: 200
    height: 150


