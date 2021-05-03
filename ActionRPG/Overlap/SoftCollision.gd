extends Area2D

# 是否重叠
func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

# 给与一个方向
func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position) # 获取自己到重叠的第一个物体的方向
		push_vector = push_vector.normalized()
	return push_vector
