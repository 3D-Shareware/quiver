class_name PauseMenu extends CanvasLayer

@onready var gradient: TextureRect = %Gradient
@onready var resume: MainMenuButton = %Resume as MainMenuButton
@onready var exit: MainMenuButton = %Exit as MainMenuButton
# tweens
@onready var fade_in: ControlTween = %FadeIn as ControlTween
@onready var fade_out: ControlTween = %FadeOut as ControlTween

@onready var buttons : Array[MainMenuButton] = [
	resume,
	exit
]

## Kevin-approved code! Hope this works and doesn't break anything.
var stored_mouse_mode: Input.MouseMode = Input.MOUSE_MODE_VISIBLE

const MAIN_MENU = preload("uid://da4hhvghhnoi8")


func _ready() -> void:
	gradient.modulate = Color.TRANSPARENT
	open_pause_menu()


func close_pause_menu(button_pressed : MainMenuButton = resume) -> void:
	fade_out.do_tween()
	await MainMenuButton.outro_all_buttons(button_pressed, buttons)
	GameManager.unpause_game()
	Input.set_mouse_mode(stored_mouse_mode)
	self.queue_free()


func open_pause_menu() -> void:
	stored_mouse_mode = Input.mouse_mode
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.pause_game()
	fade_in.do_tween()
	# stagger buttons on begin
	await MainMenuButton.intro_all_buttons(buttons)


func _on_resume_pressed() -> void:
	await close_pause_menu(resume)


func _on_exit_pressed() -> void:
	await close_pause_menu(exit)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.switch_scene_to_packed(MAIN_MENU)
