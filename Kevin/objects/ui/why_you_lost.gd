extends RichTextLabel

@onready var anim = $"AnimationPlayer"

func loser(from_ammo: bool):
	var leading_text = "[center]"
	if from_ammo:
		text = leading_text + "Out of arrows!"
	else:
		text = leading_text + "Time's up!"
	anim.play("come_in")

func winner():
	text = "[center]Victory!"
	anim.play("come_in")
