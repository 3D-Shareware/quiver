extends MicroGame

const TIME = 15

@onready var player: Node3D = $"Node3D/Player"
#@onready var camera: Camera3D = $"Player/Camera3D"

@onready var arrow_ui = $"CanvasLayer/Control/Arrow UI Center"
@onready var clock_timer = $"CanvasLayer/Control/Timer"

@onready var node3d: Node3D = $"Node3D"

@onready var light: OmniLight3D = $"Node3D/Light"

@onready var quick_loss_timer: Timer = $"Quick Loss Timer"
@onready var win_or_lose_timer: Timer = $"Win or Lose Timer"

var target = preload("res://Kevin/objects/target.tscn")
var targets_left: int = 0
var max_ammo: int = 6

var arrows_left_to_land: int

var game_over = false
var won = false

func _ready() -> void:
	# REMOVE THIS CODE AFTERWARD!?
	GameManager.get_node("Background").hide()
	#camera.set_current(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	targets_left = 3
	for i in targets_left:
		var new_target = target.instantiate()
		node3d.add_child(new_target)
		new_target.ready_by_parent(Vector3(24, 2 + (i * 3), randi_range(-4, 4)))
	arrows_left_to_land = max_ammo
	difficulty = 0
	player.ready_by_parent(max_ammo, Vector3(8 - (difficulty * 32), 4, 0))
	arrow_ui.ready_by_parent(max_ammo)
	clock_timer.reset_time(TIME)

func nock_arrow() -> void:
	arrow_ui.nock_arrow()

func shoot_arrow() -> void:
	arrow_ui.shoot_arrow()

func target_hit() -> void:
	targets_left -= 1
	if targets_left == 0:
		win()

func arrow_landed() -> void:
	arrows_left_to_land -= 1
	if arrows_left_to_land == 0:
		quick_loss_timer.start()

func win():
	if !game_over:
		won = true
		game_over = true
		light.light_color = Color(0, 1, 0)
		win_or_lose_timer.start()

func lose():
	if !game_over:
		game_over = true
		light.light_color = Color(1, 0, 0)
		win_or_lose_timer.start()

func end_and_exit():
	GameManager.get_node("Background").show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if won:
		GameManager.win()
	else:
		GameManager.lose()


func _on_quick_loss_timer_timeout() -> void:
	lose()


func _on_win_or_lose_timer_timeout() -> void:
	# TEMPORARY CODE BRO
	# should run end_and_exit() instead of any of this nonsense
	get_tree().reload_current_scene()
	#end_and_exit()
