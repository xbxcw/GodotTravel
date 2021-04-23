extends TextureRect

var inventory = preload("res://Data/Inventory.tres")

func get_drag_data(_position):
	var item_index = get_parent().get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var drag_preview = TextureRect.new()
		drag_preview.texture = texture
		set_drag_preview(drag_preview)
		return data
