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
  selectedItem = null
  previouslySelectedItem = null

  rows = ->
    (I.items.length / I.columns).ceil()

  columns = ->
    I.columns

  # Inherit from game object
  self = GameObject(I)

  self.unbind "draw"

  self.bind "draw", (canvas) ->
    I.items.each (item) ->
      item.draw(canvas)

  self.bind "moveCursor", (direction) ->
    if I.items.length
      I.cursor = I.cursor.add(direction)

      selectedIndex = Math.min(I.items.length, I.cursor.x.mod(columns()) + I.cursor.y.mod(rows()) * I.columns)

      previouslySelectedItem = selectedItem
      selectedItem = I.items[selectedIndex]

      selectedItem.selected true
      previouslySelectedItem?.selected false

      I.cursor = Point(selectedIndex.mod(columns()), (selectedIndex / columns()).floor())

  self.bind "launchApp", ->
    chrome.management.launchApp(appIds[0])

  I.items.each (item, i) ->
    itemSize = I.width / I.columns

    column = i % I.columns
    row = (i / I.columns).floor()
    x = column * itemSize
    y = row * itemSize

    item.I.x = x + itemSize/10
    item.I.y = y + itemSize/10

  if selectedItem = I.items.first()
    selectedItem.selected true

  # We must always return self as the last line
  return self

