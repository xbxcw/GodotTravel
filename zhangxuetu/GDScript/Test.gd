# 测试物品场景

extends PanelContainer

onready var propertyLabel = $HBoxContainer/VBoxContainer/PropertyLabel
onready var equipPanel = $HBoxContainer/EquipmentPanel

#----------------------
# 节点自带方法
#----------------------
func _ready():
	propertyLabel.text = formatDataToText(equipPanel.allProperty)

#----------------------
# 自定义方法
#----------------------
# 格式转化为数据转为text
func formatDataToText(data):
	var text = ''
	for key in data:
		text += key + ':' + str(data[key]) + '\n'
	return text

#-----------------------
# 链接信号
#-----------------------



func _on_EquipmentPanel_property_changed(oldValue, newValue):
	# 显示装备栏里的属性
	print(newValue)
	propertyLabel.text = formatDataToText(newValue)
