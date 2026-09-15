extends CharacterBody3D

func ready_by_parent(spawn_pos: Vector3) -> void:
	position = spawn_pos

func get_hit() -> void:
	collision_layer = 1
	get_parent().get_parent().target_hit()
