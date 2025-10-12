extends Sprite2D

func _ready() -> void:
	%AnimationPlayer.seek(randf_range(0.0, 2.0));
