extends Node3D

@onready var object = get_parent() 
var draggable = false
var is_inside_droppable = false
var body_ref
var initial_pos
var offset

func _process(_delta):
	if !draggable:
		return
	if Input.is_action_just_pressed("click"):
		initial_pos = object.global_position
		DragUnit.is_dragging = true
	if Input.is_action_pressed("click"):
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_length = 100
		var from = get_viewport().get_camera_3d().project_ray_origin(mouse_pos)
		var to = from + get_viewport().get_camera_3d().project_ray_normal(mouse_pos) * ray_length
		var space = get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.from = from
		ray_query.to = to
		ray_query.collide_with_areas = true
		ray_query.collision_mask = 0x0002
		var raycast_result = space.intersect_ray(ray_query)
		object.global_position = raycast_result.position
	elif Input.is_action_just_released("click"):
		DragUnit.is_dragging = false
		if is_inside_droppable:
			body_ref.drop_object(object)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(object, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_3d_mouse_entered():
	if not DragUnit.is_dragging:
		draggable = true
		scale = Vector3(1.05, 1.05, 1.05)

func _on_area_3d_mouse_exited():
	if not DragUnit.is_dragging:
		draggable = false
		
		scale = Vector3(1, 1, 1)

func _on_area_3d_body_entered(body):
	if body.is_in_group("dropable"):
		is_inside_droppable = true
		body_ref = body

func _on_area_3d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_droppable = false
		body_ref = null
