extends Area2D

# 史莱姆移动速度
@export var slime_speed: float = -100


func _physics_process(delta: float) -> void:
	position += Vector2(slime_speed,0) * delta

# 碰撞检测
func _on_body_entered(body: Node2D) -> void:
	# 如果 body 属于 CharacterBody2D（人物对象）
	if body is CharacterBody2D:
		# 游戏结束
		body.game_over()
