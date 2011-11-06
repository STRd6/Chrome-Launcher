appIds = [
  "booheljepkdmiiennlkkbghacgnimbdn" # Red Ice
]

# Display a coverflow or grid to select the app to launch

chrome.management.get appIds[0], ({icons}) ->
  icons.each (iconInfo) ->
    console.log iconInfo

$(document).bind "keydown", "return", ->
  chrome.management.launchApp(appIds[0])

