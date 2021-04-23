extends TextureRect

const ItemNode = preload("res://Scence/Item.tscn")
var inventory = preload("res://Data/Inventory.tres")


func update_item(item):
	if item is Item:
		var item_node = ItemNode.instance()
		item_node.texture = item.texture
		add_child(item_node)
	else:
		for current_item in get_children():
			current_item.queue_free()


func can_drop_data(_position, data):
	return data is Dictionary and data.has('item')


func drop_data(_position, data):
	var my_item_index = get_index()

	var my_item = inventory.items[my_item_index]
	print(data.item_index)
	
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount

	else:
		inventory.swap_items(my_item_index, data.item_index)
		inventory.set_item(my_item_index, data.item)
