extends Node2D

# 史莱姆的场景
@export var slime_scene:PackedScene
# 史莱姆的定时
@export var slime_timer:Timer

# 简单区别：
# _physics_process 涉及图形驱动（基于硬件配置实现的效果），不一定按每秒执行
# _process 不需要图形的驱动，按每秒执行
func _process(delta: float) -> void:
	# 设置定时器Time随机时间
	slime_timer.wait_time -= 0.2 * delta
	# 设置定时器Time随机时间，固定在指定范围内 1~ 3
	slime_timer.wait_time  = clamp(slime_timer.wait_time,1,3)

# 基于信号 timeout 调用，作用：生成史莱姆敌人
func _spawn_slime() -> void:
	# 史莱姆 对象生成
	var slime_node = slime_scene.instantiate()
	# 设置 史莱姆 位置（x固定、y范围区间163-249)
	slime_node.position = Vector2(502,randf_range(163,249))
	# 当前场景中添加 史莱姆 对象（主界面Game中可以隐藏，作用：仅在刚开始一个史莱姆对象用于预览）
	get_tree().current_scene.add_child(slime_node)
