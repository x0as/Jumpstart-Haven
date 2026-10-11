extends Label

func _ready() -> void:
	add_to_group("caught_ui")
	visible = false

func show_caught() -> void:
	if visible:
		return

	visible = true
	await get_tree().create_timer(1.2).timeout
	visible = false
