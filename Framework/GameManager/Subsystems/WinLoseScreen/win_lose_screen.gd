class_name WinLoseScreen extends Control

# fade in/out
@onready var fade_to_black: ControlTween = %FadeToBlack
@onready var fade_from_black: ControlTween = %FadeFromBlack
# stat displays
@onready var lives_stat_display: FloatStatDisplay = %LivesStatDisplay
@onready var wins_stat_display: FloatStatDisplay = %WinsStatDisplay
@onready var difficulty_stat_display: FloatStatDisplay = %DifficultyStatDisplay

var old_save_data : SaveData = SaveData.new()
var new_save_data : SaveData = SaveData.new()

const PAUSE_AMOUNT : float = 1.5


func _ready() -> void:
	self.visible = false


func play_anim() -> void:
	# setting the stat displays up
	lives_stat_display.set_ui_with_no_anim(old_save_data.lives)
	wins_stat_display.set_ui_with_no_anim(old_save_data.wins)
	difficulty_stat_display.set_ui_with_no_anim(old_save_data.current_difficulty)
	
	# do fade in
	self.visible = true
	
	# do anims
	await wins_stat_display.do_anim(new_save_data.wins)
	await lives_stat_display.do_anim(new_save_data.lives)
	await difficulty_stat_display.do_anim(new_save_data.current_difficulty)
	
	self.visible = false


#region recording whether values have changed
func _on_lives_changed(old : int, new : int) -> void:
	old_save_data.lives = old
	new_save_data.lives = new


func _on_wins_changed(old : int, new : int) -> void:
	old_save_data.wins = old
	new_save_data.wins = new


func _on_difficulty_changed(old : float, new : float) -> void:
	old_save_data.current_difficulty = old
	new_save_data.current_difficulty = new
#endregion
