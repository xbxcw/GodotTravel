## Goods Property

## 资源类型，用于GoodsList 显示属性

tool # 工具类, 用于在编辑器中实现显示效果

extends Resource

# 物品属性(物品的属性名字写在下面，用于后面方便获取与设置物品的属性)
# 这样，我们只用在这里添加键值，然后修改的时候也不会影响以后的通过key值
# 去设置属性的代码

const GoodsProperty = {
	Name = 'goodsName',
	Texture = 'goodsTextrue',
	Price = 'price',
	Damage = 'damage',
	MoveSpeed = 'moveSpeed',
	AttackSpeed = 'attackSpeed'
}

signal goods_texture_changed(textrue_) # 物品贴图发生改变信号

export var goodsName = '' #物品名
export (Texture) var goodsTexture setget set_GoodsTexture # 物品描述
export (String, MULTILINE) var goodsDescription # 物品描述
export var price = 0 # 价格
export var damage = 0 # 伤害
export var moveSpeed = 0 # 移动速度
export var attackRange = 0 # 攻击范围


#--------------------
# setget
#--------------------

# 设置物品的图片
func set_GoodsTexture(value):
	goodsTexture = value
	emit_signal('goods_texture_changed', value)

# 返回物品的属性
func get_property():
	var propertyList = GoodsProperty.values() # 获取所有属性名
	var data = {}
	for property in propertyList:
		var propertyValue = get(property)
		data[property] = propertyValue
	return data

# 设置物品的属性
func set_property(propertyDict):
	for key in propertyDict:
		var value = propertyDict[key]
		set(key,value)
