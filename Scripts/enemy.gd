extends Area2D

# 史莱姆移动速度
@export var slime_speed: float = -40
# 动画对象
@export var animator: AnimatedSprite2D

# 是否死亡
var is_dead:bool = false

# 物理处理的帧率与物理同步，即 delta 参数通常不变
func _physics_process(delta: float) -> void:
	if not is_dead :
		position += Vector2(slime_speed,0) * delta
		
	if position.x < -39:
		#prints("史莱姆 销毁")
		queue_free()

# 碰撞检测 - 和玩家碰撞
func _on_body_entered(body: Node2D) -> void:
	# 如果 body 属于 CharacterBody2D（人物对象），并且史莱姆当前非死亡状态，才判断当前玩家输掉游戏
	if body is CharacterBody2D and not is_dead:
		# 游戏结束
		body.game_over()

# 碰撞检测 - 和子弹碰撞
func _on_area_entered(area: Area2D) -> void:
	# Bullet的Area2D设置一个分组，判断当前area是否bullet组的（因为子弹是多个对象发射）
	if area.is_in_group("bullet"):
		# 史莱姆 状态，死亡
		is_dead = true 
		# 获取当前主场景（因为score在主场景下，通过获取当前场景，间接获取主场景的对象）
		get_tree().current_scene.score += 1
		# 子弹场景，销毁
		area.queue_free()
		# 播放，史莱姆死亡动画
		animator.play("dead")
	 	# 播放史莱姆死亡音效
		$DeadthSound.play()	
		# 等待0.6秒
		await get_tree().create_timer(0.6).timeout
		# 史莱姆场景，销毁（若不销毁，则史莱姆死亡动画会一直移动到屏幕外）
		queue_free()
		
