extends TextureRect

var inventory = preload("res://Data/Inventory.tres")

var item_data

onready var amount_label = $Amount

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
		inventory.drag_data = data
		return data


func update_amount():
	
	if item_data.amount > 1:
		amount_label.text = str(item_data.amount)
	else:
		amount_label.text = ''

func _ready():
	update_amount()
