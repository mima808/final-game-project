extends Node

@onready var forest_player : AudioStreamPlayer = $Forest
@onready var point_player : AudioStreamPlayer = $Point
@onready var win_player   : AudioStreamPlayer = $Win
@onready var click_player   : AudioStreamPlayer = $Click

func _ready() -> void:
	forest_player.play()

func play_point() -> void:
	point_player.play()

func play_win() -> void:
	win_player.play()
func play_click() -> void:
	click_player.play()
