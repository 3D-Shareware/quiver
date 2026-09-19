extends Node3D

@onready var anim = $"AnimationPlayer"

func open_up() -> void:
	anim.play("open")
