extends MicroGame

const TIME = 15

var shot_a_good_arrow = false

@onready var player: Node3D = $"Node3D/Player"
@onready var moving_floor: Node3D = $"Node3D/Moving Floor"
#@onready var camera: Camera3D = $"Player/Camera3D"

@onready var arrow_ui = $"CanvasLayer/Control/Bottom Right/Arrow UI Center"
@onready var clock_timer = $"CanvasLayer/Control/Bottom Left/Clock Timer"
@onready var why_you_lost = $"CanvasLayer/Control/CenterContainer/Why You Lost"
@onready var perfect_arrow_text = $"CanvasLayer/Control/Bottom Middle/Perfect Arrow"

@onready var scope: TextureProgressBar = $"CanvasLayer/Control/CenterContainer/ScopeBar"

@onready var node3d: Node3D = $"Node3D"

@onready var light: OmniLight3D = $"Node3D/Light"
@onready var shadow: OmniLight3D = $"Node3D/Shadow"

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
	difficulty = randf_range(0, 1)
	GameManager.get_node("Background").hide()
	#camera.set_current(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	targets_left = 3
	# starting position of targets. Helps produce y placement variety.
	var rand_y_origin = randi_range(2, 4)
	# Number of moving targets. Determined by difficulty with no RNG.
	var moving_target_count = min(3, int(difficulty * 4))
	# All new targets are added here so I can MOVE them around.
	var all_targets = []
	for i in targets_left:
		var new_target = target.instantiate()
		node3d.add_child(new_target)
		new_target.ready_by_parent(Vector3(28, rand_y_origin + (i * 3), randi_range(-6, 6)))
		all_targets.append(new_target)
	# Picks random targets to start moving.
	for i in moving_target_count:
		if all_targets.size() > 0:
			all_targets.pop_at(randi_range(0, all_targets.size() - 1)).start_moving(randf_range(3, 3.5 + difficulty * 6))
		else:
			break
	arrows_left_to_land = max_ammo
	moving_floor.position.x = 26 - (difficulty * 32)
	player.ready_by_parent(max_ammo, Vector3(16 - (difficulty * 32), 4, 0), scope)
	arrow_ui.ready_by_parent(max_ammo)
	clock_timer.reset_time(TIME)
	why_you_lost.intro()

func nock_arrow() -> void:
	arrow_ui.nock_arrow()

func shoot_arrow(charge: float) -> void:
	if charge <= 0.2 and !shot_a_good_arrow:
		perfect_arrow_text.you_are_stupid()
	else:
		shot_a_good_arrow = true
	arrow_ui.shoot_arrow()

func target_hit() -> void:
	targets_left -= 1
	if targets_left == 0:
		win()

func secret_hit() -> void:
	shadow.light_negative = false
	arrows_left_to_land += player.restock()
	arrow_ui.restock()

## Adds two arrows left to land to prevent game from making you lose early from running out of arrows.
func perfect_arrow_shot() -> void:
	arrows_left_to_land += 2
	perfect_arrow_text.perfect()

func arrow_landed() -> void:
	arrows_left_to_land -= 1
	if arrows_left_to_land == 0:
		quick_loss_timer.start()

func win():
	if !game_over:
		won = true
		game_over = true
		light.light_color = Color(0, 1, 0)
		clock_timer.stop_running()
		win_or_lose_timer.start()
		why_you_lost.winner()

func lose(from_ammo: bool):
	if !game_over:
		game_over = true
		light.light_color = Color(1, 0, 0)
		clock_timer.stop_running()
		win_or_lose_timer.start()
		why_you_lost.loser(from_ammo)
		

func end_and_exit():
	GameManager.get_node("Background").show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if won:
		GameManager.win()
	else:
		GameManager.lose()


## If ammo runs out and the last arrow clearly hasn't hit anything important.
func _on_quick_loss_timer_timeout() -> void:
	if !arrows_left_to_land:
		lose(true)


func _on_win_or_lose_timer_timeout() -> void:
	# TEMPORARY CODE BRO
	# should run end_and_exit() instead of any of this nonsense
	#end_and_exit()
	get_tree().reload_current_scene()
