extends Area2D

var default = preload("res://assets/cheeseplt_default.png")
var deut = preload("res://assets/cheeseplt_deut.png")
var prot = preload("res://assets/cheeseplt_prot.png")
var trit = preload("res://assets/cheeseplt_trit.png")

#@export var dimmer_path : NodePath
#@onready var dimmer : ColorRect = get_node(dimmer_path)

func _ready():
	updateShader()
	
func updateShader():
	# 0 default, 1 deut, 2 prot, 3 trit
	print(LevelManager._get_colorblind())
	match LevelManager._get_colorblind():
		0:
			$Sprite2D.material.set_shader_parameter("new_palette", default)
		1:
			$Sprite2D.material.set_shader_parameter("new_palette", deut)
		2:
			$Sprite2D.material.set_shader_parameter("new_palette", prot)
		3:
			$Sprite2D.material.set_shader_parameter("new_palette", trit)
		_:
			$Sprite2D.material.set_shader_parameter("new_palette", default)

func _on_body_entered(body: Node2D) -> void:
	print("Something entered:", body.name)
	if body.is_in_group("player"):
		body.level_ends()
