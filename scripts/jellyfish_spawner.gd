extends Node2D

@export var n_jellyfish := 4;
@export var rotation_period := 15.0;
@export var jelly_scene := preload("res://scenes/jellyfish.tscn")
@export var base_radius := 65.0;
@export var suck_speed := 15.0;

var jellyfish := [];
var frequencies := [];
var phases := [];
var amplitudes := [];
var radius := base_radius;

var time := 0.0;
var float_score := 0.0;

func _ready() -> void:
	for i in range(n_jellyfish):
		var jelly := jelly_scene.instantiate();
		jellyfish.append(jelly);
		add_child(jelly);
		jelly.moaj = %MOAJ;
		
		phases.append(randf_range(-PI, PI));
		frequencies.append(randf_range(0.5, 2.0));
		amplitudes.append(randf_range(4.0, 8.0));
		
func _process(delta: float) -> void:
	for i in range(n_jellyfish):
		if not is_instance_valid(jellyfish[i]):
			await get_tree().create_timer(2.5).timeout;
			on_game_over();
			return;
		var phi := float(i) / n_jellyfish * TAU;
		var radius_i = radius + sin(time * frequencies[i] + phases[i]) * amplitudes[i];
		jellyfish[i].global_position = radius_i * Vector2(cos(TAU * time / (rotation_period) + phi), sin(TAU * time / (rotation_period) + phi));
	
	time += delta;
	float_score += delta * (1.0 + log(time));
	Global.score = round(float_score);
	%ScoreLabel.text = str(Global.score);
	
	if Input.is_action_pressed("suck"):
		radius = clamp(radius - delta * suck_speed, 20.0, base_radius);
	else:
		radius = clamp(radius + delta * suck_speed * 0.25, 20.0, base_radius);

func on_game_over() -> void:
	Global.save_high_score();
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn");	
