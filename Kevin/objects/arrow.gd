extends CharacterBody3D

var speed: float = 45 # usually
var flying: bool = true

var game: Node3D

func spawn_by_parent(spawn_pos: Vector3, spawn_rotation: Vector3) -> void:
	position = spawn_pos
	rotation = spawn_rotation
	game = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if flying:
		var collision = move_and_collide(-transform.basis.z * delta * speed)
		if collision != null:
			flying = false
			game.arrow_landed()

func _on_area_3d_body_entered(body: Node3D) -> void:
	body.get_hit()
