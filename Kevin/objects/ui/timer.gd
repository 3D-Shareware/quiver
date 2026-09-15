extends Sprite2D

var time: int = 15

var running = false

@onready var game = get_parent().get_parent().get_parent()
@onready var text = $"RichTextLabel"
@onready var timer = $"Timer"

func reset_time(max_time: int) -> void:
	time = max_time
	update_time()
	timer.start()
	running = true

func update_time() -> void:
	text.text = str(time)
	if time <= 0:
		game.lose()
		stop_running()

func stop_running() -> void:
	running = false
	timer.stop()

func _on_timer_timeout() -> void:
	if running:
		time -= 1
		update_time()
