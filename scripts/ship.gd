extends RigidBody3D

@export var main_thrust := 22.0
@export var side_thrust := 8.0
@export var rotation_torque := 12.0
@export var max_landing_speed := 4.0
@export var max_landing_tilt_degrees := 12.0
@export var fuel := 100.0
@export var fuel_burn := 18.0

var landed := false
var crashed := false

@onready var engine_light: OmniLight3D = $EngineLight
@onready var exhaust_core: GPUParticles3D = $ExhaustCore
@onready var exhaust_smoke: GPUParticles3D = $ExhaustSmoke


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	exhaust_core.emitting = false
	exhaust_smoke.emitting = false


func _physics_process(delta: float) -> void:
	if landed or crashed:
		return

	var main_input := Input.get_action_strength("thrust_up")
	var side_input := Input.get_action_strength("thrust_right") - Input.get_action_strength("thrust_left")
	var rotate_input := Input.get_action_strength("rotate_right") - Input.get_action_strength("rotate_left")

	var using_engine := main_input > 0.0 and fuel > 0.0

	if using_engine:
		apply_central_force(Vector3(0.0, main_thrust * main_input, 0.0))
		fuel = maxf(0.0, fuel - fuel_burn * delta)

	if fuel > 0.0:
		apply_central_force(Vector3(side_thrust * side_input, 0.0, 0.0))
		apply_torque(Vector3(0.0, 0.0, -rotation_torque * rotate_input))
		fuel = maxf(0.0, fuel - absf(side_input + rotate_input) * fuel_burn * 0.35 * delta)

	engine_light.visible = using_engine
	exhaust_core.emitting = using_engine
	exhaust_smoke.emitting = using_engine


func _on_body_entered(body: Node) -> void:
	if crashed or landed:
		return

	var vertical_speed := absf(linear_velocity.y)
	var tilt := rad_to_deg(absf(rotation.z))

	if body.is_in_group("landing_pad"):
		if vertical_speed <= max_landing_speed and tilt <= max_landing_tilt_degrees:
			landed = true
			freeze = true
			exhaust_core.emitting = false
			exhaust_smoke.emitting = false
			print("Landing successful. Impact speed: %.2f, tilt: %.1f degrees" % [vertical_speed, tilt])
		else:
			crashed = true
			exhaust_core.emitting = false
			exhaust_smoke.emitting = false
			print("Crashed on pad. Speed: %.2f, tilt: %.1f degrees" % [vertical_speed, tilt])
	else:
		crashed = true
		exhaust_core.emitting = false
		exhaust_smoke.emitting = false
		print("Crashed into terrain.")
