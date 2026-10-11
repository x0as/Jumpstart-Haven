extends Node2D

const CoinScript = preload("res://coin.gd")

@export var tilemap_path: NodePath = ^"../TileMapLayer"
@export var coin_count: int = 8
@export var coin_texture: Texture2D
@export var coin_radius: float = 20.0   

var tilemap: TileMapLayer
var spots: Array[Vector2i] = []
var taken: Dictionary = {}


func _ready() -> void:
	tilemap = get_node_or_null(tilemap_path) as TileMapLayer
	if tilemap == null:
		push_error("CoinSpawner: TileMapLayer not found at tilemap_path")
		return

	for solid in tilemap.get_used_cells():
		var top: Vector2i = solid + Vector2i.UP
		var above: Vector2i = top + Vector2i.UP
		if tilemap.get_cell_source_id(top) == -1 and tilemap.get_cell_source_id(above) == -1:
			spots.append(top)

	for i in coin_count:
		_spawn_coin()


func _spawn_coin() -> void:
	if spots.is_empty() or taken.size() >= spots.size():
		return

	var cell: Vector2i = spots.pick_random()
	for _i in 30:
		if not taken.has(cell):
			break
		cell = spots.pick_random()
	if taken.has(cell):
		return
	taken[cell] = true

	var coin: Area2D = CoinScript.new()
	coin.texture = coin_texture
	coin.radius = coin_radius
	add_child(coin)
	coin.global_position = tilemap.to_global(tilemap.map_to_local(cell))
	coin.collected.connect(_on_coin_collected.bind(cell))


func _on_coin_collected(cell: Vector2i) -> void:
	taken.erase(cell)
	_spawn_coin.call_deferred()
