extends RigidBody2D

@export var kick_force: float = 200
@export var max_speed := 200
@export var cooldown := 1000

var last_kick_time = -1 * cooldown
var dir = 0
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Input.is_action_pressed("power_kick"):
		kick_ball(get_global_mouse_position(), Time.get_ticks_msec())

func kick_ball(mouse_pos: Vector2, curr_ticks: int):
	if curr_ticks > last_kick_time + cooldown:
		dir = (global_position - mouse_pos).normalized()
		apply_impulse(dir*kick_force)
		last_kick_time = curr_ticks
	
func _physics_process(_delta):
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
