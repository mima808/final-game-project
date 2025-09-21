extends Control

@export var menu_scene_path : String = "res://scenes/MainMenu.tscn"

func _ready() -> void:
	$Last/VBoxContainer/ReplayButton.pressed.connect(Callable(self, "_on_BackButton_pressed"))

func _on_BackButton_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene_path)
	AudioManager.play_click()
