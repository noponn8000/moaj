class_name Mine extends Node2D

@export var direction: Vector2;
@export var speed := 20.0;
@export var expl_scene := preload("res://scenes/explosion.tscn");

func _physics_process(delta: float) -> void:
	position += direction * speed * delta;

func die() -> void:
	var explosion := expl_scene.instantiate();
	explosion.global_position = self.global_position;
	
	get_tree().root.add_child(explosion);
	queue_free();
