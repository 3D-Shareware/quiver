
## vvv Notice how this script starts with:
## 'class_name SomeUniqueName extends MicroGame'
## ^^^ You need to 'extends MicroGame' at the start of your game!
class_name ExampleMicrogame extends MicroGame


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		## vvv This is the line you need to run to let the player win your MicroGame!
		GameManager.win()
	elif Input.is_action_just_pressed("q"):
		## vvv This is the line you need to run to let the player win your MicroGame!
		GameManager.lose()


## YOUR TASK: Figure out how to add THIS MicroGame into the 'MicroGameQueue'
## HINT: Look in game_manager.tscn and find the 'MicroGameQueue'. Remember
## to look at the editor on the right-hand side of your screen ------------------------------------------------>
## There's a funny array there that you can modify >:)
## 
## Second hint: Drag & Drop
##
## If you did this correctly, you should see it show up when you run the game!
