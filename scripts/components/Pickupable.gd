extends Node3D
class_name Pickupable

@onready var root : RigidBody3D = self.get_parent()
@export var id : int # Can I make this a drop down? Reference an objDB?
var pick_up_scene : PackedScene
var put_down_scene : PackedScene


func _ready():
	pick_up_scene = Db.pickup_db.data[id].pick_up_scene
	put_down_scene = Db.pickup_db.data[id].put_down_scene


func pickup(handPosition : Node3D) -> int:
	if pick_up_scene:
		var instance = pick_up_scene.instantiate()
		handPosition.add_child(instance)
		instance.set_global_position(handPosition.get_global_position())
		root.queue_free()
		return id
	push_error("Failed to get pick_up_scene")
	return -1
