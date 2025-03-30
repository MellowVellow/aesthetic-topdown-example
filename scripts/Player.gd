extends GameEntity
class_name Player

var sprint_speed = 100.0
var desired_speed: float
var can_input = true

var input_vector = Vector2.ZERO
var last_input_vector = Vector2.ZERO

var dash_force = 200.0
@onready var is_dashing = false
var MAX_DASHES = 3
var dash_count = 3
var REGEN_RATE = 1
@export var can_move: bool = true

@export var hptext: Label
@export var hpbar: TextureProgressBar
var healthbarui: String
@export var staminabar: TextureProgressBar

func ready_for_input():
	can_input = true

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	healthbarui = str(Health_component.current_health)+ "/" + str(stats_component.max_health)
	hptext.text = healthbarui
	hpbar.value = Health_component.current_health
	staminabar.value = dash_count
	dash_count = min((dash_count + delta) * REGEN_RATE, MAX_DASHES)

	if input_vector != Vector2.ZERO:
		last_input_vector = input_vector #usecase when anim & moving when no input
		velocity = input_vector * desired_speed
		
		

func _on_dash_timer_timeout():
	is_dashing = false
