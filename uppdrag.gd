extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ladda_pressed():        
	read_file("1")

func _on_ladda_2_pressed():
	read_file("2")

func _on_ladda_3_pressed():
	read_file("3")

func read_file(id):
	var file = FileAccess.open("res://01.json", FileAccess.READ)        
	if file != null:                     
		var json_data = file.get_as_text()                
		
		file.close()
		
		
		var json_parser = JSON.new()
		
		# Parse the JSON data                
		
		var json_dict = json_parser.parse_string(json_data)
		
		# Check if json_dict is not null and if it has the "game" key                
		
		if json_dict != null and json_dict.has("game"):                       
			
			var games = json_dict["game"]
			# Loop through the games                        
			
			for game in games:                                                
				
				print("Game Dictionary Contents:")                                               
				
				if game["id"] == id: # Choose the first game for the example                                                            
					
					var name = game["name"]                                                                                                                      
					var year = game["year"]
					var image = game["image"]
					var text = game["text"]
					var effect = game["effect"]
					$"Bält".text = "Name: " + str(name) + "\nYear: " + str(year) + "\nimage: " + str(image) + "\ntext: " + str(text) + "\neffect: " + str(effect)                                                         
					
					load_image(image)
					return           
	
	else:                    
		
		print("Kunde inte öppna filen.")


func load_image(image_url):
	var image_src = image_url        
	var image_texture = ImageTexture.new()        
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	var error = http_request.request(image_src)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		

func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")

	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	var texture = ImageTexture.create_from_image(image)

	# Display the image in a TextureRect node.
	$Image.texture = texture
