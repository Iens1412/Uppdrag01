extends Node2D

var artifact_instances = []
var names = []    
var years = []    
var images = []    
var texts = []    
var effects = []

var name2 = ""
var year2 = ""
var image2 = ""
var text2 = ""
var effect2 = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var artifact_scene = preload("res://artifact.tscn")
	var script = preload("res://uppdrag.gd").new()
	
	for i in range(3):       
		script.name_info(name2, year2, image2, text2, effect2)
		
		# Assign variables to lists       
		names.append(script.name4[i])        
		years.append(script.year4[i])       
		images.append(script.image4[i])     
		texts.append(script.text4[i])
		effects.append(script.effect4[i])
	
	for i in range(3):        
		var artifact_instance = artifact_scene.instantiate() 
		add_child(artifact_instance)        
		artifact_instances.append(artifact_instance)
		
		var button = artifact_instance.get_node("Button")
		var label = artifact_instance.get_node("Label")
		var txtur_rect = artifact_instance.get_node("Image")

		if i == 0:
			artifact_instances[i].show()
		else:
			artifact_instances[i].hide()
			
		button.text = "Inställning " + str(i + 1)
		label.text = str(names[i])
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_on_next_pressed():
	for i in range(3):
		if artifact_instances[i].is_visible_in_tree():
			artifact_instances[i].hide()
			var next_index = (i + 1) %3
			artifact_instances[next_index].show()
			break


func _on_on_prev_pressed():
	for i in range(3):
		if artifact_instances[i].is_visible_in_tree():
			artifact_instances[i].hide()
			var prev_index = (i - 1) %3
			artifact_instances[prev_index].show()
			break

func info():
	print("is called")
	var script = preload("res://uppdrag.gd").new()
	
	for i in range(3):       
		script.name_info(name2, year2, image2, text2, effect2)
		
		# Assign variables to lists       
		names.append(script.name4[i])        
		years.append(script.year4[i])       
		images.append(script.image4[i])     
		texts.append(script.text4[i])
		effects.append(script.effect4[i])
