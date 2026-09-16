extends RichTextLabel

@onready var anim = $"AnimationPlayer"

func loser(from_ammo: bool):
	var leading_text = "[center]"#[color=#FF0000]"
	if from_ammo:
		text = leading_text + "Out of ammo!"
	else:
		text = leading_text + "Time's up!"
	anim.play("come_in")
