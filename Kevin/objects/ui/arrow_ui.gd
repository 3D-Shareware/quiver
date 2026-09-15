extends Sprite2D

@onready var anim = $"AnimationPlayer"

func nock() -> void:
	anim.play("nock")

func fade_out() -> void:
	anim.stop(true)
	anim.play("fade_to_black")
