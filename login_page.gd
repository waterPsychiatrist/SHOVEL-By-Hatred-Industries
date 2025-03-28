extends Control
var srotspeed : Vector3 = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	srotspeed = Vector3(randf_range(0.1, 15), randf_range(0.1, 15), randf_range(0.1, 15))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$SubViewport/ShovelModel.rotation_degrees += srotspeed / 50
