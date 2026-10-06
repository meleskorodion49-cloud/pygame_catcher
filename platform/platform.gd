extends CharacterBody2D


const SPEED = 1000
@export var coins=0

func _ready() -> void:
	coins=GlobalCoins.coins
	if GlobalCoins.player_position!=Vector2.ZERO:
		position=GlobalCoins.player_position
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	var screen_width = get_viewport_rect().size.x
	position.x = clamp(position.x, $CollisionShape2D.shape.radius*1.5, screen_width-$CollisionShape2D.shape.radius*1.5)
	GlobalCoins.player_position=position
	GlobalCoins.save_data()
