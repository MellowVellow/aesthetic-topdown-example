extends Node
class_name HealthComponent
var is_critical: bool = false
#handles all damage and converts into effective dmg for health
#get a stats component?

@export var stats_component: StatsComponent
var current_health: int

func _ready():
	current_health = stats_component.max_health
	
func take_damage(damage, crit_chance):
	var effective_damage: float = effective_damage(damage, crit_chance)
	effective_damage = floor(effective_damage)  # Round up damage
	effective_damage = max(effective_damage, 0)
	current_health -= effective_damage
	print(effective_damage)
	DamageNumbers.display_number(effective_damage, get_parent().get_node("DamageNumbersOrigin").global_position, is_critical)

	if current_health <= 0:
		onDeath()

func onDeath():
	get_parent().queue_free()
	print("died")

func defense(atk) -> float:
	if atk == 0 and stats_component.defense == 0:
		return 0.0
 
	return ( atk / (atk+stats_component.defense+1) )

func crit(chance) -> float:
	var num = randf_range(0,1)
 
	if num < chance:
		is_critical = true
		return 2.0
	else:
		is_critical = false
		return 1.0


func effective_damage(atkdmg, crit_chance) -> float:
	var damage: float = atkdmg * defense(atkdmg) * crit(crit_chance)
	return damage
 
