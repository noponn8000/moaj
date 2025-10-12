extends Node2D

@export var mine_scene := preload("res://scenes/mine.tscn");
@export var timer: Timer;

func _ready() -> void:
	timer.start();
	
func _on_timer_timeout() -> void:
	spawn_mine();
	timer.start();
	
func spawn_mine() -> void:
	var quadrant := randi_range(0, 4);
	var pos: Vector2;
	
	match quadrant:
		0:
			pos = Vector2i(-100, randi_range(-80, 80));
		1:
			pos = Vector2i(randi_range(-80, 80), -100);
		2:
			pos = Vector2i(100, randi_range(-80, 80));
		3:
			pos = Vector2i(randi_range(-80, 80), 100);

	var sign := 1.0 if randf() > 0.5 else -1.0;
	var direction := pos.direction_to(Vector2.ZERO).rotated(randf_range(1.0 * sign, 0.3 * sign));
	
	var mine := mine_scene.instantiate();
	mine.global_position = pos;
	mine.direction = direction;
	add_child(mine);
