MAX_JOYSTICKS = 8

appIds = [
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
]

window.engine = Engine 
  clear: true
  canvas: $("canvas").pixieCanvas()
  includedModules: ["Joysticks"]

launchableApps = appIds.map (appId) ->
  LaunchableApp
    id: appId

# Display a coverflow or grid to select the app to launch
grid = engine.add
  class: "Grid"
  items: launchableApps

engine.start()

# Keybord Cursor Movement
["left", "right", "up", "down"].each (direction) ->
  pointDirection = Point[direction.toUpperCase()]

  $(document).bind "keydown", direction, ->
    grid.trigger "moveCursor", pointDirection

$(document).bind "keydown", "return", ->
  grid.trigger "launchApp"

# Joystick Cursor Movement
MAX_JOYSTICKS.times (i) ->
  controller = engine.controller(i)
    .bind "tap", (pointDirection) ->
      grid.trigger "moveCursor", pointDirection

engine.bind "update", ->
  MAX_JOYSTICKS.times (i) ->
    controller = engine.controller(i)

    if controller.buttonPressed("A") or controller.buttonPressed("START")
      grid.trigger "launchApp"

