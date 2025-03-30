extends PlayerState

@export var _animation_tree: NodePath
@onready var animation_tree:AnimationTree = get_node(_animation_tree)

func enter(_msg := {}) -> void:
	animation_tree.get("parameters/playeranims/playback").travel("walk")
	
	
func physics_update(_delta: float) -> void:
	animation_tree.set("parameters/playeranims/walk/blend_position", player.input_vector)
	
	player.desired_speed = player.stats_component.move_speed
	player.move_and_slide()
	if player.input_vector == Vector2.ZERO:
		state_machine.transition_to("Idle")
	if Input.is_action_pressed("sprint"):
		state_machine.transition_to("Sprint")
	if Input.is_action_pressed("dash") and player.dash_count >= 1:
		state_machine.transition_to("Dash")
		player.dash_count -= 1
		player.is_dashing = true
	if Input.is_action_pressed("attack"):
		state_machine.transition_to("Slash")
