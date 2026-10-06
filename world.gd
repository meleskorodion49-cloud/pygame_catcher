extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

@export var object_to_spawn: PackedScene
# Ссылка на 2-ю сцену (или узел внутри нее), куда спавнить
@export var target_scene: Node2D
var game_scene_path="res://escMenu/escMenu.tscn"
func spawn_coin() -> void:
	var okno=get_viewport_rect().size
	if object_to_spawn and target_scene:
		var new_node = object_to_spawn.instantiate()
		var collision = new_node.get_node_or_null("CollisionShape2D")
		var radis=collision.shape.radius
		var random_x=randf_range(radis,okno.x-radis)
		var random_y=randf_range(radis,okno.y/3)
		target_scene.add_child(new_node)
		new_node.global_position=Vector2(random_x,random_y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var chance = randf()
	if chance<=0.01:
		spawn_coin()
	if Input.is_action_just_pressed("press_esc"):
		get_tree().change_scene_to_file(game_scene_path)
