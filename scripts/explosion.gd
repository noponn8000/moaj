extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%GPUParticles2D.emitting = true;
	%AudioStreamPlayer.play();
	await get_tree().create_timer(2.0).timeout;
	queue_free();
