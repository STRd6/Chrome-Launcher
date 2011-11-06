LaunchableApp = (I={}) ->
  # Set some default properties
  Object.reverseMerge I,
    color: "blue"
    height: 128
    width: 128

  # Inherit from game object
  self = GameObject(I)

  # Add events and methods here
  self.bind "update", ->
    ; # Add update method behavior

  # We must always return self as the last line
  return self

