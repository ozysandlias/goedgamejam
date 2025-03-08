extends Resource

var current_health: float = 4

func damage(amount):
	current_health -= amount

func heal(amount):
	current_health += amount
