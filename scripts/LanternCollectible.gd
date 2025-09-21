extends Area2D

signal collected(lantern: Area2D)

var _collected : bool = false

func _ready() -> void:
	add_to_group("lanterns")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if _collected:
		return
	if body.name != "Player":
		return
	_collected = true

	AudioManager.play_point()

	emit_signal("collected", self)
	queue_free()
