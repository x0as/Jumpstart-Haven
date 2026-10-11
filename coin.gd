class_name Coin
extends Area2D


signal collected

@export var value: int = 1
@export var radius: float = 20.0
@export var texture: Texture2D


func _ready() -> void:
	if texture != null:
		var sprite := Sprite2D.new()
		sprite.texture = texture
		var s: float = (radius * 2.0) / float(texture.get_width())
		sprite.scale = Vector2(s, s)
		add_child(sprite)

	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = radius
	shape.shape = circle
	add_child(shape)

	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.name != "Player":
		return
	get_tree().call_group("hud", "add_score", value)
	collected.emit()
	queue_free()


func _draw() -> void:
	if texture != null:
		return
	draw_circle(Vector2.ZERO, radius, Color(1.0, 0.85, 0.1))
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 32, Color(0.6, 0.45, 0.0), 3.0)
