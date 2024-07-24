extends RefCounted

#class_name PickupDB

enum {
	MISSILE_CASING
}


var pick_up_scene = {
	MISSILE_CASING: load("res://scenes/pickedups/Missile_Casing_Pickedup.tscn")
}

var put_down_scene = {
	MISSILE_CASING: load("res://scenes/interactables/Missile_Casing.tscn")
}

var data = {}

func _init():
	_add_obj_data(MISSILE_CASING)


func _add_obj_data(pickup_id : int):
	data[pickup_id] = PickupableData.new(pickup_id, pick_up_scene[pickup_id], put_down_scene[pickup_id])
