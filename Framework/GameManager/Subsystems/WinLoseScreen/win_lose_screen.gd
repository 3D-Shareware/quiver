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


func play_anim() -> void:
	# setting the stat displays up
	lives_stat_display.set_ui_with_no_anim(old_save_data.lives)
	wins_stat_display.set_ui_with_no_anim(old_save_data.wins)
	difficulty_stat_display.set_ui_with_no_anim(old_save_data.current_difficulty)
	
	# check if we need to do anims
	var do_lives_anim : bool = false
	var do_wins_anim : bool = false
	var do_difficulty_anim : bool = false
	
	# checking if new values differ from old values
	if old_save_data.lives != new_save_data.lives:
		do_lives_anim = true
	if old_save_data.wins != new_save_data.wins:
		do_wins_anim = true
	if is_equal_approx(old_save_data.current_difficulty, new_save_data.current_difficulty):
		do_difficulty_anim = true
	
	# do fade in
	self.visible = true
	fade_from_black.do_tween()
	await fade_from_black.tween_finished
	
	# do anims if vals differ
	if do_lives_anim: 
		lives_stat_display.do_anim(new_save_data.lives)
	if do_wins_anim: 
		wins_stat_display.do_anim(new_save_data.wins)
	if do_difficulty_anim: 
		difficulty_stat_display.do_anim(new_save_data.current_difficulty)
	
	# pause then fade to black
	await get_tree().create_timer(PAUSE_AMOUNT).timeout
	fade_to_black.do_tween()
	await fade_to_black.tween_finished


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
