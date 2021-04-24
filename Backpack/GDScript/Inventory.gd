extends Resource

class_name Inventory

export(Array, Resource) var items
var drag_data

signal items_changed(indexes)


func set_item(item_index,item):
	var current_item = items[item_index]
	items[item_index] = item
	emit_signal("items_changed",[item_index])
	return current_item
	
func remove_item(item_index):
	var current_item = items[item_index]
	items[item_index] = null
	emit_signal("items_changed",[item_index])
	return current_item
	
func swap_items(item_index,target_item_index):
	var target_item = items[target_item_index]
	var item = items[item_index]
	
	items[target_item_index] = item
	items[item_index] = target_item
	emit_signal("items_changed",[item_index,target_item_index])

func make_items_unique():
	var unique_items = []
	for item in items:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	items = unique_items
