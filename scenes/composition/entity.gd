extends CharacterBody2D

class_name Entity

@onready var health_component =  $HealthComponent as HealthComponent
@onready var hitbox_component = $HitboxComponent as HitboxComponent
@onready var hurtbox_component = $HurtboxComponent as HurtboxComponent

func _ready():
	# Initialize components
	pass

func take_damage(damage):
	health_component.apply_damage(damage)
	if health_component.is_dead():
		queue_free()
