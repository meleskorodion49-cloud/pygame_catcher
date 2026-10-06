extends Area2D

signal count(coin : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	$".".position.y+=5
	if $".".position.y>=get_viewport_rect().size.y:
		$".".queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body:
		body.coins+=1
		GlobalCoins.coins=body.coins
		GlobalCoins.save_data()
		$".".queue_free()
		
		
