extends Control

export(int) var id: int = 17
var state = "hide"
var done:bool = false

signal clicked(id)

func _ready() -> void:
	randomize()
	$front.frame = id
	
	yield(get_tree().create_timer(randf()), "timeout")
	$anim.play("start")

func _on_touch_pressed() -> void:
	if done: return

	if !get_node("../../")._can_play(): return

	if $anim.is_playing(): return

	if state == 'hide':
		emit_signal("clicked", id)
		_show()

func _hide() -> void:
	yield(get_tree().create_timer(randf() / 8), "timeout")
	state = 'hide'
	$anim.play_backwards("show")

func _show() -> void:
	state = 'show'
	$anim.play("show")
	$sfx.play()

func _set_done(_state):
	done = _state
	modulate.a = .5
