Grid = (I={}) ->
  # Set some default properties
  Object.reverseMerge I,
    columns: 4
    height: App.height
    width: App.width
    x: 0
    y: 0
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

    cursorRow = I.cursor.y.mod(rows())
    cursorColumn = I.cursor.x.mod(columns())

    I.items.each (item, i) ->
      column = i % I.columns
      row = (i / I.columns).floor()
      x = column * itemSize
      y = row * itemSize

      item.selected(column is cursorColumn and row is cursorRow)
      item.draw(canvas)

  self.bind "moveCursor", (direction) ->
    I.cursor = I.cursor.add(direction)

  I.items.each (item, i) ->
    itemSize = I.width / I.columns

    column = i % I.columns
    row = (i / I.columns).floor()
    x = column * itemSize
    y = row * itemSize

    item.I.x = x + itemSize/10
    item.I.y = y + itemSize/10

  # We must always return self as the last line
  return self

