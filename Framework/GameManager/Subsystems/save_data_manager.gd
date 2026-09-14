class_name SaveDataManager extends Node

@onready var save_data : SaveData = SaveData.new()

func _ready() -> void:
	# stop game from immediately closing
	get_tree().auto_accept_quit = false


func _notification(what: int) -> void:
	if what != Node.NOTIFICATION_WM_CLOSE_REQUEST:
		return
	# save data before closing
	GameSaver.save_data_to_file(save_data)
	# close normally
	get_tree().quit()


## Counts won games
func _handle_won_game() -> void:
	print('handling won game')
	save_data.wins += 1
	print(save_data.wins)


## Counts lives lost
func _handle_lost_game() -> void:
	print('handling lost game')
	
	save_data.lives -= 1
	print(save_data.lives)


## Track difficulty changed
func _on_difficulty_chnaged(difficulty : float) -> void:
	print('handling difficulty change')
	print(difficulty)
	save_data.current_difficulty = difficulty
