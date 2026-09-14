class_name SaveData

const DEFAULT_LIVES : int = 3
const DEFAULT_WINS : int = 0
const DEFAULT_DIFFICULTY : float = 0.0

var wins : int = 0:
	set(value):
		wins_changed.emit(wins, value)
		wins = value
var lives : int = 0:
	set(value):
		lives_changed.emit(lives, value)
		lives = value
var current_difficulty : float = 0:
	set(value):
		difficulty_changed.emit(current_difficulty, value)
		current_difficulty = value


signal wins_changed(old : int, new : int)
signal lives_changed(old : int, new : int)
signal difficulty_changed(old : float, new : float)


func _init() -> void:
	self.wins = DEFAULT_WINS
	self.lives = DEFAULT_LIVES
	self.current_difficulty = DEFAULT_DIFFICULTY


func clear() -> void:
	wins = DEFAULT_WINS
	lives = DEFAULT_LIVES
	current_difficulty = DEFAULT_DIFFICULTY


func get_as_dict() -> Dictionary[String, Variant]:
	return {
		"wins": wins,
		"lives": lives,
		"current_difficulty": current_difficulty,
	}


## [param data] is not cast as Dictionary[String, Variant] because of JSON string parsing
static func from_dict(data : Dictionary) -> SaveData:
	var save_data = SaveData.new()
	
	 #if the data does not have any of these arguments, the values get set to the default 
	# param (0) passed into the get func, so this is safe!
	save_data.wins = data.get("wins", 0)
	save_data.lives = data.get("lives", 0)
	save_data.current_difficulty = data.get("current_difficulty", 0)
	
	return save_data
