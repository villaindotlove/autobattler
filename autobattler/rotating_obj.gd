extends MeshInstance3D

func _process(delta):
	rotation += Vector3(0.0, delta * 5.0, delta * 1.0)
