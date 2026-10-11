extends CanvasLayer
## Put this on your CanvasLayer node. It builds its own labels, no UI setup needed.

@export var game_time: float = 60.0

var time_left: float
var score: int = 0
var game_over: bool = false
var can_restart: bool = false

var timer_label: Label
var score_label: Label
var end_label: Label


func _ready() -> void:
	add_to_group("hud")
	process_mode = Node.PROCESS_MODE_ALWAYS   # keeps running while the game is paused
	time_left = game_time

	timer_label = _make_label(56)
	timer_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE, Control.PRESET_MODE_MINSIZE, 16)
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	score_label = _make_label(40)
	score_label.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_MINSIZE, 24)

	end_label = _make_label(64)
	end_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	end_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	end_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	end_label.visible = false

	_update_labels()


func _make_label(font_size: int) -> Label:
	var l := Label.new()
	l.add_theme_font_size_override("font_size", font_size)
	l.add_theme_color_override("font_outline_color", Color.BLACK)
	l.add_theme_constant_override("outline_size", 10)
	add_child(l)
	return l


func _process(delta: float) -> void:
	if game_over:
		return
	time_left -= delta
	if time_left <= 0.0:
		time_left = 0.0
		_end_game()
	_update_labels()


func add_score(amount: int = 1) -> void:
	if game_over:
		return
	score += amount
	_update_labels()


func _update_labels() -> void:
	timer_label.text = str(ceili(time_left))
	var urgent: bool = time_left <= 10.0
	timer_label.add_theme_color_override("font_color", Color.RED if urgent else Color.WHITE)
	score_label.text = "Score: %d" % score


func _end_game() -> void:
	game_over = true
	end_label.text = "TIME'S UP!\nScore: %d\n\nPress Enter / Space to play again" % score
	end_label.visible = true
	get_tree().paused = true

	# Short delay so a jump-mash doesn't instantly restart.
	await get_tree().create_timer(1.0).timeout
	can_restart = true


func _input(event: InputEvent) -> void:
	if game_over and can_restart and event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		get_tree().reload_current_scene()
