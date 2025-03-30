extends CharacterBody2D
class_name GameEntity

@export var stats_component: StatsComponent
@export var Health_component: HealthComponent
@export var Hurt_component: HurtboxComponent

func _ready():
	Hurt_component.connect("area_entered", Callable(self, "_on_hurtbox_area_entered"))
	print("yippee")

func _on_hurtbox_area_entered(hitbox):
	if hitbox is HitboxComponent:
		Health_component.take_damage(hitbox.stats_component.attack, hitbox.stats_component.crit_chance)
		Hurt_component.hurt_effect()
	else:
		print("youre wrong")
