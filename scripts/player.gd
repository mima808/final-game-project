extends CharacterBody2D

@export var speed : float = 250

func _physics_process(_delta: float) -> void:
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vec.length() > 0:
		input_vec = input_vec.normalized() * speed
	else:
		input_vec = Vector2.ZERO

	velocity = input_vec
	move_and_slide()

# transition to game end
func _on_game_end_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://scenes/Last.tscn")
		AudioManager.play_win()
