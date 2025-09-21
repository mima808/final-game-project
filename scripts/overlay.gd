extends CanvasLayer

@export var hole_radius : float = 0.25
@export var edge_feather : float = 0.05
@export var fade_in_time : float = 1.0
@export var wait_time : float = 6.0

var player_node : Node2D
var shader_mat : ShaderMaterial

func _ready():
	player_node = get_node("../Player") 
	var full_rect = $FullscreenRect
	shader_mat = full_rect.material as ShaderMaterial

	shader_mat.set_shader_parameter("hole_radius", hole_radius)
	shader_mat.set_shader_parameter("edge_feather", edge_feather)
	shader_mat.set_shader_parameter("overlay_alpha", 0.0)

	full_rect.visible = true

	await get_tree().create_timer(wait_time).timeout
	var tween = create_tween()
	tween.tween_property(shader_mat, "shader_parameter/overlay_alpha", 1.0, fade_in_time)

	set_process(true)

func _process(_delta):
	if player_node == null or shader_mat == null:
		return

	# player’s position
	var player_canvas_xform : Transform2D = player_node.get_global_transform_with_canvas()
	var screen_pos : Vector2 = player_canvas_xform.origin

	# visible part
	var vsz : Vector2 = get_viewport().get_visible_rect().size

	var uv : Vector2 = screen_pos / vsz
	uv.x = clamp(uv.x, 0.0, 1.0)
	uv.y = clamp(uv.y, 0.0, 1.0)

	shader_mat.set_shader_parameter("hole_center", uv)
