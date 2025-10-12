class_name Jellyfish extends Node2D

const SEGMENT_COUNT := 10;
const SEGMENT_LENGTH := 3.0

var points := []
var timer := 0.0;

@export var moaj: Node2D;

func _ready():
	# Initialize tail points
	for i in range(SEGMENT_COUNT):
		points.append(Vector2.ZERO);
	
func _process(delta: float) -> void:
	var to_moaj = moaj.global_position - global_position;
	for i in range(SEGMENT_COUNT):
		var offset = Vector2.ZERO if i == 0 or i == SEGMENT_COUNT - 1 else Vector2(sin(timer), cos(timer)) * 3.0;
		points[i] = global_position + to_moaj * (float(i) / SEGMENT_COUNT) + offset; 
		
	timer = wrapf(timer + delta, 0.0, TAU);
	queue_redraw();

func _draw():
	for j in range(0, SEGMENT_COUNT - 1):
		var p1 = round(points[j])
		var p2 = round(points[j + 1])
		draw_line(to_local(p1), to_local(p2), Color.WHITE, 1.0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Mine:
		area.owner.die();
		die();
		
func die() -> void:
	queue_free();
