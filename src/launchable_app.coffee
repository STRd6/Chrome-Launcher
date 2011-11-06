LaunchableApp = (I={}) ->
  # Set some default properties
  Object.reverseMerge I,
    color: "blue"
    height: 128
    width: 128
    sprite: "test"

  # Inherit from game object
  self = GameObject(I)

  self.unbind "draw"

  borderSize = 2

  self.bind "draw", (canvas) ->
    if I.selected
      canvas.drawRoundRect
        x: -borderSize
        y: -borderSize
        width: I.width + 2 * borderSize
        height: I.height + 2 * borderSize
        radius: 2
        color: "red"

    I.sprite.draw(canvas, -I.sprite.width/2, -I.sprite.height/2)


  self.attrAccessor "selected"

  # We must always return self as the last line
  return self

