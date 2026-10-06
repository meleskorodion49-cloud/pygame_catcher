extends Button

@export var game_scene_path: String = "res://mainMenu/mainMenu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	GlobalCoins.player_position=Vector2(557,625)
	get_tree().change_scene_to_file(game_scene_path)
	
