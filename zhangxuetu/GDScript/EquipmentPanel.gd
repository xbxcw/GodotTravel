# 装备面板

extends Panel


signal property_changed(oldValue, newValue) # 属性发生改变信号

const GoodsProperty = preload("res://GDScript/GoodsProperty.gd")

const Goods =preload("res://GDScript/Goods.gd" )

# 所有物品属性总和
var allProperty = {}

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
			print(allProperty)
			
			allProperty[property] = 0
		elif propertyType == TYPE_REAL: # float 类型
			allProperty[property] = 0.0
func _ready():
	# 连接物品信号
	for goods in get_children():
		goods.connect('swaped_property', self, '_onGoodsSwapedProperty')
		goods.connect('unload', self, '_onGoodsUnload')

#----------------------
#自定义方法
#----------------------

# 改变属性
# @property 物品属性
# @is_add 是否增加，如果为false 则为减去

func changeProperty(goodsProperty, is_add):
	var tempAllProperty = allProperty.duplicate(true)

	# 加上
	if is_add:
		for property in allProperty.keys():
			var value = goodsProperty.get(property)
			allProperty[property] += value
	# 减去
	else:
		for property in allProperty.keys():
			var value = goodsProperty.get(property)
			allProperty[property] -= value
	emit_signal('property_changed', tempAllProperty, allProperty)




#-------------------
# 连接信号
#-------------------

func _onGoodsSwapedProperty(oldProperty, newProperty):
	if oldProperty != null:
		changeProperty(oldProperty,false)  # 减去就属性
		print('换掉物品： ', oldProperty.goodsName)
	if newProperty != null:
		changeProperty(newProperty,true)
		print('装备物品： ', newProperty.goodsName)


func _onGoodsUnload(property):
	changeProperty(property, false) # 减去属性
	print('卸下物品')
