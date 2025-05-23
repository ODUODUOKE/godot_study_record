extends CharacterBody2D

# 移动速度 @export 绑定到界面
@export var move_speed : float = 100 
# 动画对象
@export var animator: AnimatedSprite2D
# 子弹的场景
@export var bullet_scene:PackedScene
# 是否游戏结束
var is_game_over:bool = false 

#启动后每秒运行（physics_process按照实际硬件处理）
func _physics_process(delta: float) -> void:
	
	if not is_game_over: 
	#	获取键盘方向输入 * 移动速度
	#	left、right、up、down 需要提前在项目中设置绑定对应按键
		velocity = Input.get_vector("left","right","up","down") * move_speed
		
	#	如果移动速度 = 0，则显示 idle 动画
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			#显示 run 动画
			animator.play("run")

		#移动
		move_and_slide()  
	
	
# 游戏结束	
func game_over() -> void:
	is_game_over = true
	# 播放游戏结束动画
	animator.play("game_over")
	# 等待3s执行
	await get_tree().create_timer(3).timeout
	# 开始游戏，重新加载场景
	get_tree().reload_current_scene()
	


# 子弹发射
func on_fire() -> void:
	# 如果玩家位置移动不等于0 或 游戏结束，则return不进行以下代码逻辑
	if velocity!=Vector2.ZERO or is_game_over:
		return
	
	# 生成子弹对象
	var bullet_node = bullet_scene.instantiate()
	# 设置发射子弹的位置（玩家位置）+偏移变量（子弹需要在玩家前方一定位置）
	bullet_node.position = position + Vector2(50,47)
	# 添加子弹到当前场景中
	get_tree().current_scene.add_child(bullet_node)
	
	
	
	
