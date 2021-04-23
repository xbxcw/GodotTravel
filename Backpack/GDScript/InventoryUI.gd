extends WindowDialog

var inventory  = preload("res://Data/Inventory.tres")
onready var container = $GridContainer

func _input(event):
	if event.is_action_pressed("Inventory"):
		popup()
func _ready():
	inventory.connect("items_changed",self,"on_item_changed")
	for item_index in inventory.items.size():
		update_slot(item_index)

func update_slot(item_index):
	var slot = container.get_child(item_index)
	var item = inventory.items[item_index]
	slot.update_item(item)

func on_item_changed(indexes):
	for item_index in indexes:
		update_slot(item_index)
