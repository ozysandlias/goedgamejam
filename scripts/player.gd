extends Node3D

# Sensitivity of the mouse movement
var mouse_sensitivity: float = 0.1
# Rotation angles
var yaw: float = 0.0
var pitch: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
    # Hide the mouse cursor and capture it
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# This function is called when a mouse motion event occurs
func _input(event):
    if event is InputEventMouseMotion:
        # Update yaw and pitch based on mouse movement
        yaw -= event.relative.x * mouse_sensitivity
        pitch -= event.relative.y * mouse_sensitivity
        
        # Clamp the pitch to prevent flipping
        pitch = clamp(pitch, -89.0, 89.0)

        # Apply the rotation to the Node3D (the parent of the Camera3D)
        rotation_degrees.x = pitch
        rotation_degrees.y = yaw