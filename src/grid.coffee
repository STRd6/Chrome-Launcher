Grid = (I={}) ->
  # Set some default properties
  Object.reverseMerge I,
    columns: 4
    height: App.height
    width: App.width
    x: App.width/2
    y: App.height/2
    color: "rgba(0, 128, 0, 0.5)"
    cursor: Point(0, 0)

  I.items ||= []

  rows = ->
    (I.items.length / I.columns).ceil()

  columns = ->
    I.columns

  # Inherit from game object
  self = GameObject(I)

  self.unbind "draw"

  self.bind "draw", (canvas) ->
    canvas.drawRect
      x: 0
      y: 0
      width: I.width
      height: I.height
      color: I.color

    itemSize = I.width / I.columns

    cursorRow = I.cursor.y % rows()
    cursorColumn = I.cursor.x % columns()

    I.items.each (item, i) ->
      column = i % I.columns
      row = (i / I.columns).floor()
      x = column * itemSize
      y = row * itemSize

      item.selected(column is cursorColumn and row is cursorRow)
      item.draw(canvas)

  self.bind "moveCursor", (direction) ->
    cursor = cursor.add(direction)

  I.items.each (item, i) ->
    itemSize = I.width / I.columns

    column = i % I.columns
    row = (i / I.columns).floor()
    x = column * itemSize
    y = row * itemSize

    item.I.x = x + itemSize/2
    item.I.y = y + itemSize/2

  # We must always return self as the last line
  return self

