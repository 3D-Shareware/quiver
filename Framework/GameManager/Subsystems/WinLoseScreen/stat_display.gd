class_name FloatStatDisplay extends HBoxContainer

@onready var counter: RichTextLabel = %Counter as RichTextLabel
@onready var icon: TextureRect = %Icon as TextureRect
@onready var progress_bar: TextureProgressBar = %ProgressBar as TextureProgressBar

@export var display_as_int : bool = false


func format_counter_text(val : float) -> String:
	if display_as_int:
		return '%.0f' % val
	else:
		return '%.2f' % val


func set_ui_with_no_anim(val : float) -> void:
	counter.text = format_counter_text(val)
	progress_bar.value = val


func do_anim(target_val : float) -> void:
	# tween progressbar value
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(progress_bar, "value", target_val, 0.5)
	# set text
	counter.text = format_counter_text(target_val)
