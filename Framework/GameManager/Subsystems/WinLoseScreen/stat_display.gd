class_name FloatStatDisplay extends Control

@export var display_as_percent : bool = false
@export var display_text : String = ""

@onready var counter: RichTextLabel = %Counter as RichTextLabel
@onready var icon: TextureRect = %Icon as TextureRect

# tweens
@onready var fade_in_counter: ControlTween = %FadeInCounter as ControlTween
@onready var fade_out_counter: ControlTween = %FadeOutCounter
@onready var bump_up: ControlTween = %BumpUp as ControlTween
@onready var bump_down: ControlTween = %BumpDown as ControlTween
@onready var reset_position_offset: ControlTween = %ResetPositionOffset as ControlTween
@onready var fade_in_icon: ControlTween = %FadeInIcon as ControlTween
@onready var fade_out_icon: ControlTween = %FadeOutIcon as ControlTween

var current_val : float = -INF


func _ready() -> void:
	counter.scale = Vector2.ZERO
	icon.scale = Vector2.ZERO


func set_ui_with_no_anim(val : float) -> void:
	counter.text = format_counter_text(val)
	current_val = val


func do_anim(target_val : float) -> void:
	await fade_in()
	
	if target_val > current_val:
		await do_increment_counter_anim(target_val)
	elif target_val < current_val:
		await do_decrement_counter_anim(target_val)
	else:
		await get_tree().create_timer(0.5).timeout


func format_counter_text(val : float) -> String:
	if display_as_percent:
		return display_text + '%.0f' % (val * 100) + "%"
	else:
		return display_text + '%.0f' % val
		


#region tween funcs
func fade_in() -> void:
	# fade in icon first
	await fade_in_icon.do_tween()
	await fade_in_counter.do_tween()


func fade_out() -> void:
	# fade out counter first
	await fade_out_counter.do_tween()
	await fade_out_icon.do_tween()


func do_increment_counter_anim(target_val : float) -> void:
	await bump_up.do_tween()
	counter.text = format_counter_text(target_val)
	await reset_position_offset.do_tween()


func do_decrement_counter_anim(target_val : float) -> void:
	await bump_down.do_tween()
	counter.text = format_counter_text(target_val)
	await reset_position_offset.do_tween()
#endregion
