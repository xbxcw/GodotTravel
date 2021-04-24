# 装备面板

extends Panel


signal property_changed(oldValue, newValue) # 属性发生改变信号

const GoodsProperty = preload("res://GDScript/GoodsProperty.gd")

const Goods =preload("res://GDScript/Goods.gd" )

# 所有物品属性总和
var allProperty

#--------------
# 结点自带方法
#-------------

func _init():
	# 临时属性， 用于获取变量判断类型
	var tempGoodsProperty = GoodsProperty.new() 

	# 属性列表， 用于获取变量名
	var goodsPropertyList = GoodsProperty.GoodsProperty

	# 以下是为了先将需要的属性记录到 allProperty 字典中，方便计算

	for property in goodsPropertyList.values():
		var value = tempGoodsProperty.get(property) # 属性值
		var propertyType = typeof(value) # 属性类型

		# 如果是 int 类型 或是 float 类型则记录到 allProperty 中
		if propertyType == TYPE_INT: # int 类型
			allProperty[property] = 0
		elif propertyType == TYPE_REAL: # float 类型
			allProperty[property] = 0.0
func _ready():
	# 连接物品信号
	for goods in get_children():
		goods.connect('swaped_property', self, '_ongoods')