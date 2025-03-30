extends PlayerState

@export var _animation_tree: NodePath
@onready var animation_tree:AnimationTree = get_node(_animation_tree)

@export var _dash_timer: NodePath
@onready var dash_timer: Timer = get_node(_dash_timer)

func enter(_msg := {}) -> void:
	animation_tree.get("parameters/playeranims/playback").travel("dash")
	dash_timer.start()
	get_node("../../Fei").disabled = true
	get_node("../../HurtboxComponent/CollisionShape2D").disabled = true
	
	
func physics_update(_delta: float) -> void:
	animation_tree.set("parameters/playeranims/dash/blend_position", player.last_input_vector)
	if player.is_dashing:
		player.desired_speed = player.dash_force
		player.move_and_slide()
	else:
		state_machine.transition_to("Idle")

func exit():
	get_node("../../Fei").disabled = false
	get_node("../../HurtboxComponent/CollisionShape2D").disabled = false
