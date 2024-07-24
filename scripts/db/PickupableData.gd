extends RefCounted
class_name PickupableData

var pickup_id : int
var pick_up_scene : PackedScene
var put_down_scene : PackedScene

func _init(_pickup_id : int, _pick_up_scene : PackedScene, _put_down_scene : PackedScene):
	pickup_id = _pickup_id
	pick_up_scene = _pick_up_scene
	put_down_scene = _put_down_scene
