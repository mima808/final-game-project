extends Node2D

@export var hole_radius_start : float = 0.25
@export var hole_radius_increment : float = 0.05
const MAX_SCORE : int = 7

var score : int = 0

@onready var score_label : Label = get_node_or_null("UI/ScoreLabel")
@onready var overlay_fullrect : CanvasItem = get_node_or_null("Overlay/FullscreenRect")
var overlay_shader_mat : ShaderMaterial = null
@onready var player : Node = get_node_or_null("Player")
@onready var mushend_node : Node = get_node_or_null("mushend")  # make sure name matches in the scene tree!

@export var fade_all_time : float = 1.0  # fade duration

func _ready() -> void:
	if overlay_fullrect and overlay_fullrect.material is ShaderMaterial:
		overlay_shader_mat = overlay_fullrect.material as ShaderMaterial
		overlay_shader_mat.set_shader_parameter("hole_radius", hole_radius_start)

	_update_score_label()

	# "lanterns" group
	for lantern in get_tree().get_nodes_in_group("lanterns"):
		if lantern and lantern.has_signal("collected"):
			lantern.connect("collected", Callable(self, "_on_lantern_collected"))

func _on_lantern_collected(_lantern_node: Node) -> void:
	score += 1
	_update_score_label()

	# shader hole radius (ta3deel)
	if overlay_shader_mat:
		var current_radius : float = overlay_shader_mat.get_shader_parameter("hole_radius")
		overlay_shader_mat.set_shader_parameter("hole_radius", current_radius + hole_radius_increment)

	print("Lantern collected! Score:", score)


	if score >= MAX_SCORE:
		_on_all_lanterns_collected()

func _update_score_label() -> void:
	if score_label:
		score_label.text = "Score: " + str(score) + " / " + str(MAX_SCORE)

func _on_all_lanterns_collected() -> void:
	print("All lanterns collected!")

	# overlay fade out (lel final screen w el player)
	if overlay_shader_mat:
		if overlay_fullrect and overlay_fullrect.has_method("create_tween"):
			var t = overlay_fullrect.create_tween()
			t.tween_property(overlay_shader_mat, "shader_parameter/overlay_alpha", 0.0, fade_all_time)
		else:
			overlay_shader_mat.set_shader_parameter("overlay_alpha", 0.0)

	# mushend fade out lel player bardo
	if mushend_node:
		if mushend_node.has_node("Mush"):
			var spr = mushend_node.get_node("Mush")
			if spr is CanvasItem:
				if spr.has_method("create_tween"):
					var t2 = spr.create_tween()
					t2.tween_property(spr, "modulate:a", 0.0, fade_all_time)
				else:
					var m = spr.modulate
					m.a = 0.0
					spr.modulate = m
		elif mushend_node is CanvasItem:
			var t3 = mushend_node.create_tween()
			t3.tween_property(mushend_node, "modulate:a", 0.0, fade_all_time)

	# to disable the collission shape for the player to pass
	if mushend_node:
		for child in mushend_node.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", true)
			else:
				# Also check deeper levels
				# if child has or contains a CollisionShape2D
				var deeper = child.get_node_or_null("CollisionShape2D")
				if deeper and deeper is CollisionShape2D:
					deeper.set_deferred("disabled", true)
