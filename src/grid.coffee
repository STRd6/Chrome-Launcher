Grid = (I={}) ->
  # Set some default properties
  Object.reverseMerge I,
    columns: 4
    height: App.height
    width: App.width
    x: 0
    y: 0

  I.items ||= []

  # Inherit from game object
  self = GameObject(I)

  self.unbind "draw"

  self.bind "draw", (canvas) ->
    itemSize = I.width / I.columns

    I.items.each (item, i) ->
      column = i % I.columns
      row = (i / I.columns).floor()

      item.draw(canvas, column * itemSize, row * itemSize)

  # We must always return self as the last line
  return self

