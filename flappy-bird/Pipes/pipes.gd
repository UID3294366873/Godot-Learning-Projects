extends Node2D

const SPEED = -150    # 向左移动速度
var passed = false    # 标记bird是否安全通过该管道，以防重复计分

@onready var coin: Area2D = $Coin
@onready var pipe_bottom: Area2D = $PipeBottom
@onready var pipe_top: Area2D = $PipeTop
@onready var animation_player: AnimationPlayer = $Coin/AnimationPlayer
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	# 当小鸟撞上管道时触发
	pipe_bottom.body_entered.connect(on_pipe_body_entered)
	pipe_top.body_entered.connect(on_pipe_body_entered)
	
	# 当小鸟撞上金币触发
	coin.body_entered.connect(on_coin_body_entered)
	
	# 管道完全离开屏幕时触发
	visible_on_screen_notifier_2d.screen_exited.connect(on_exited)

func on_pipe_body_entered(body):
	if body.is_in_group("bird") and not body.is_dead:
		# TODO: 触发游戏结束逻辑
		pass
	
func on_coin_body_entered(body):
	if body.is_in_group("bird") and not passed:
		passed = true
		animation_player.play("coin")
		
		await animation_player.animation_finished
		coin.queue_free()
	
	
func on_exited():
	queue_free()
	

func _procee(delta):
	position.x += delta * SPEED
