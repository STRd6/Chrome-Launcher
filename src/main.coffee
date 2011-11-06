appIds = [
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
  ""
  ""
  ""
  ""
  ""
  ""
  ""
  ""
  ""
  ""
  ""
]

window.engine = Engine 
  backgroundColor: 'black'
  canvas: $("canvas").pixieCanvas()
  includedModules: ["Flash"]

launchableApps = appIds.map (appId) ->
  LaunchableApp
    id: appId

# Display a coverflow or grid to select the app to launch
grid = engine.add
  class: "Grid"
  items: launchableApps

engine.start()

chrome.management?.get appIds[0], ({icons}) ->
  icons.each (iconInfo) ->
    console.log iconInfo

$(document).bind "keydown", "return", ->
  chrome.management.launchApp(appIds[0])

["left", "right", "up", "down"].each (direction) ->
  pointDirection = Point[direction.toUpperCase()]

  console.log pointDirection

  $(document).bind "keydown", direction, ->

    grid.trigger "moveCursor", pointDirection

