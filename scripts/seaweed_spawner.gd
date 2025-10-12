extends Node2D

@export var n_seaweed := 32;
@export var seaweed_scene := preload("res://scenes/seaweed.tscn");

func _ready() -> void:
	for i in range(n_seaweed):
		var seaweed := seaweed_scene.instantiate();
		add_child(seaweed);
		seaweed.global_position = Vector2i(randi_range(-80, 80), randi_range(-80, 80));
