extends Control

@export var game_scene_path : String = "res://scenes/game.tscn"
@export var rules_scene_path : String = "res://scenes/Rules.tscn"

func _ready() -> void:
	$VBoxContainer/PlayButton.pressed.connect(Callable(self, "_on_PlayButton_pressed"))
	$VBoxContainer/HowToPlay.pressed.connect(Callable(self, "_on_HowToPlay_pressed"))

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to_file(game_scene_path)
	AudioManager.play_click()

func _on_HowToPlay_pressed() -> void:
	get_tree().change_scene_to_file(rules_scene_path)
	AudioManager.play_click()
