extends Node2D

var arrow_ui = preload("res://Kevin/objects/ui/arrow_ui.tscn")

var children = []

func ready_by_parent(arrow_count: int) -> void:
	for i in arrow_count:
		var new_arrow = arrow_ui.instantiate()
		add_child(new_arrow)
		new_arrow.position = Vector2(-i * 32, 0)
		children.append(new_arrow)
	#children[-1].ready_up()

func nock_arrow() -> void:
	if !children.is_empty():
		children[-1].nock()

func shoot_arrow() -> void:
	if !children.is_empty():
		children[-1].fade_out()#modulate = Color.DIM_GRAY
		children.pop_at(-1)
	#if !children.is_empty():
		#children[-1].ready_up()
