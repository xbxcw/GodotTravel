# Goods
# 物品
tool
extends CenterContainer

const GoodsProperty = preload("res://GDScript/GoodsProperty.gd")

export (Resource) var goodsProperty setget set_goodsProperty

onready var textureRect = $TextureRect 

export (Texture) var background setget set_background
onready var backgroundRect = $Background

#-------------------------
# setget
#-------------------------

func set_goodsProperty(value):
	if not value is GoodsProperty:
		goodsProperty = null
		textureRect.texture = null
		return
	goodsProperty = value
	
	# texturRect 为 null 时代表还没加载到场景中
	# 所以我们要 yields 等待当前节点发出 ready 信号
	# 当前节点 ready 后 textureRect 在他之前加载了
	if textureRect == null:
		# 当前节点发出 ready 信号后在继续执行后面的语句
		yield(self,'ready')
	# 链接资源的 goods_texutre_changed 信号
	# goods_texture_changed 信号附加有 texture
	# 连接到textureRect 的 set_texture 函数上
	# goods_texture 属性改变的时候
	# 将会调用 textureRect 的 set_texture 函数

	if not goodsProperty.is_connected('goods_texture_changed', textureRect, 'set_texture'):
		goodsProperty.connect('goods_texture_changed',textureRect,'set_texture')
	textureRect.texture = value.goodsTexture

var dragSource # 用于记录上一个拖拽的节点(物品放下后给这个节点交换数据)

#-------------------------------------------
# 节点自带的方法
#-------------------------------------------
func get_drag_data(_position):
	var dragNode = self.duplicate() # 复制一份当前的节点，用于拖拽显示
	dragNode.use_top_left = true #使图片剧中 看起来自然
	dragNode.dragSource = self # 复制用于拖拽的节点记录当前拖拽的源节点
	set_drag_preview(dragNode) # 设置鼠标拖拽的节点
	dragNode.backgroundRect.visible = false
	return dragNode

func can_drop_data(_position, data):
	# 判断能否放在这个节点上
	return data and data.get('goodsProperty') # 有 goodsProperty 属性才能放下

# warning-ignore:unused_argument
func drop_data(_position, data):
	# 接收放下的节点数据
	swapGoods(self,data.dragSource)

#-----------------------------
# 自定义方法
#----------------------------

signal swaped_property(oldProperty,newProperty) # 交换属性
signal unload(property) #卸下物品
func swapGoods(a,b):

	#交换物品信号
	emit_signal('swaped_property', a.goodsProperty, b.goodsProperty)
	emit_signal('swaped_property', b.goodsProperty, a.goodsProperty)

	# 卸下物品信号
	if a == null:
		emit_signal('unload', b.goodsProperty)
	if b == null:
		emit_signal('unload', a.goodsProperty)

	var p_temp = a.goodsProperty
	a.goodsProperty = b.goodsProperty
	b.goodsProperty = p_temp



func set_background(value):
	background = value
	if backgroundRect == null:
		yield(self, 'ready')
	backgroundRect.texture = value
