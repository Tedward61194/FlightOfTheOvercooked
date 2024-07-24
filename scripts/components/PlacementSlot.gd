class_name PlacementSlot extends Node3D
# refs
@onready var holding_ray := $RayCast3D

@export var placement_slot_id : int
@export var accept_list : PackedInt32Array = [] # Empty list can accept any item

func try_put_down(obj_in_hands : int) -> bool:
	var processed_id = choose_obj_to_place(obj_in_hands)
	if processed_id != -1:
		place_object(processed_id)
	return processed_id != -1


func choose_obj_to_place(obj_in_hands:int) -> int:
	var processed_obj_id = -1
	var holding_id = get_holding_id()
	if accept_list.is_empty() || accept_list.has(obj_in_hands):
		if holding_id == -1:
			processed_obj_id = obj_in_hands
		else:
			# TODO: processed_obj_id = Db.recipe_db.search_by_data(holding_id,obj_in_hands,placement_slot_id)
			pass
			if processed_obj_id != -1 and holding_id != -1:
				destroy_object_being_held()
	return processed_obj_id

func get_holding_id(): # Could be more performant to store holding?
	var col = holding_ray.get_collider()
	if col and col.has_node("Pickupable"):
		return col.get_node("Pickupable").id
	return -1


func destroy_object_being_held():
	holding_ray.get_collider().queue_free()


func place_object(obj_id : int):
	var new_obj = Db.pickup_db.data[obj_id].put_down_scene.instantiate()
	self.add_child(new_obj)
	new_obj.set_global_position(Vector3( \
		self.get_global_position().x, \
		self.get_global_position().y + 1, \
		self.get_global_position().z))
	check_auto_interact(new_obj)


func check_auto_interact(new_obj):
	if new_obj.has_node("AutoInteract"):
		new_obj.get_node("AutoInteract").try_start_interact(placement_slot_id)
