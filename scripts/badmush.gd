extends CharacterBody2D

@export var speed: float = 450
@export var direction: Vector2 = Vector2.LEFT   

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)

	if collision:
		direction = -direction
