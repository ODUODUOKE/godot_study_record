extends Area2D

# 子弹的速度
@export var bullet_speed:float = 100

func _ready() -> void:
	# 生成一个3s的定时并等待时间结束
	await get_tree().create_timer(3).timeout
	# 释放当前子弹对象（性能优化-当持续允许长时间后会生成多个子弹对象）
	queue_free()

# 基于物理硬件性能的实时每帧运行
func _physics_process(delta: float) -> void:
	# 子弹的发射（基于位置的移动），delta：表示实际每秒运行速度
	position += Vector2(bullet_speed,0)*delta 
