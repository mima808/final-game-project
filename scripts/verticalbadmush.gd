extends CharacterBody2D

@export var speed: float = 300
@export var direction: Vector2 = Vector2.UP   

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)

	if collision:
		direction = -direction
