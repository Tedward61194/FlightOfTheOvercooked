class_name Highlightable extends MeshInstance3D

@onready var shader = self.mesh.material.next_pass

@export var targeted := false:
	get:
		return targeted
	set(val):
		targeted = val
		if targeted:
			shader.set_shader_parameter("strength", 0.2)
		else:
			shader.set_shader_parameter("strength", 0.0)
