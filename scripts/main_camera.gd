extends Camera3D

@export var target_path: NodePath
@export var follow_speed := 5.0

@onready var target: Node3D = get_node(target_path)


func _process(delta: float) -> void:
	if target == null:
		return

	var target_position := target.global_position
	target_position.z = global_position.z
	global_position = global_position.lerp(target_position, follow_speed * delta)
