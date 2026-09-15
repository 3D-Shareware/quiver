extends Node3D

@onready var camera_pivot = $"CameraPivot"
@onready var game = get_parent().get_parent()

const MOUSE_SENSITIVITY = 0.002
const CHARGE_MIN = 0.5

var charge_time: float = 0
var ammo: int = 0

var arrow = preload("res://Kevin/objects/arrow.tscn")

# let's a play
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var camera_movement: Vector2
		camera_movement = event.screen_relative * -MOUSE_SENSITIVITY
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x + camera_movement.y, -PI / 2, PI / 2)
		camera_pivot.rotate_y(camera_movement.x)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("kevin_quiver_game_arrow") or charge_time:
		if !charge_time:
			game.nock_arrow()
		charge_time += delta
	if !Input.is_action_pressed("kevin_quiver_game_arrow") and (charge_time >= CHARGE_MIN) and ammo:
		var new_arrow = arrow.instantiate()
		add_sibling(new_arrow)
		new_arrow.spawn_by_parent(camera_pivot.global_position, camera_pivot.global_rotation)
		game.shoot_arrow()
		ammo -= 1
		charge_time = 0
	if Input.is_action_just_pressed("ctrl"):
		get_tree().quit()

func ready_by_parent(new_ammo: int, spawn_pos: Vector3):
	ammo = new_ammo
	position = spawn_pos
