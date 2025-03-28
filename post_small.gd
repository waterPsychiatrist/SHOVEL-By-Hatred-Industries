extends Control
var postTitle : String = ""
var postRabbitHole : String = ""
var noun : String = "Wizards"
var politicalParty : String = "abraxas"
var person : String = "Dean Winchester"
var newPage = load("res://post_page.tscn")
var image = load("res://PostImages.tscn")
var postPopularity = 0
var digs = 0
var opinion = 0
var window = null
#There are 5 types of post popularity: 1 - Who cares | 2 - Some People | 3 - Normal Post | 4 - Quite Popular | 5 - Industry Moving

func _ready() -> void:
	var imageInst = image.instantiate()
	imageInst.isBeingRandomlyMade = true
	$MarginContainer/ImageAndTextSeperator.add_child(imageInst)
	$MarginContainer/ImageAndTextSeperator.move_child(get_node("MarginContainer/ImageAndTextSeperator/Images"), 0)
	makePost()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func getTitle():    
	var file = "user://titles.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()

	while not list.eof_reached():
		postTitle = list.get_line()
		if rng.randi() % 10 == 0:
			return
			
func getNoun():
	var file = "user://nouns.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		noun = str(list.get_line().to_lower())
		if rng.randi() % 10 == 0:
			return
	
func getPoliticalParty():
	var file = "user://politicalparties.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		politicalParty = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
			
func getPerson():
	var file = "user://people.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		person = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
		
func randomizeTitle():
	
	if "/noun/" in postTitle:
		getNoun()
		postTitle = postTitle.replacen("/noun/", noun)
	if "/pp/" in postTitle:
		getPoliticalParty()
		postTitle = postTitle.replacen("/pp/", politicalParty)
	if "/people/" in postTitle:
		getPerson()
		postTitle = postTitle.replacen("/people/", person)
	
	
	var letterStatus = randi_range(1, 6)
	match letterStatus:
		1:
			postTitle = postTitle.to_lower()
		4:
			postTitle = postTitle.to_camel_case()
		5:
			postTitle = postTitle.capitalize()
		6:
			postTitle = postTitle.to_upper()
			
func getRabbitHole():
	var file = "user://rabbitholes.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		postRabbitHole = str(list.get_line().to_lower())
		if rng.randi() % 10 == 0:
			return

func randomizeRabbitHole():
	if "/noun/" in postRabbitHole:
		getNoun()
		postRabbitHole = postRabbitHole.replacen("/noun/", noun.replacen(" ", ""))
		print(str(noun))
	if "/pp/" in postRabbitHole:
		getPoliticalParty()
		postRabbitHole = postRabbitHole.replacen("/pp/", politicalParty.replacen(".", ""))
		print(str(noun))
	if "/people/" in postRabbitHole:
		getPerson()
		postRabbitHole = postRabbitHole.replacen("/people/", person.replacen(" ", ""))
	
	postRabbitHole = postRabbitHole.to_lower()

func makePost():
	postPopularity = randi_range(1, 5)
	if randi() % 2:
		opinion = 1
	else:
		opinion = -1
	match postPopularity:
		1:
			digs = randi_range(1, 30) * opinion
		2:
			digs = randi_range(31, 99) * opinion
		3:
			digs = randi_range(100, 300) * opinion
		4:
			digs = randi_range(301, 500) * opinion
		5:
			digs = randi_range(501, 1500) * opinion
	
	getRabbitHole()
	randomizeRabbitHole()
	getTitle()
	randomizeTitle()
	$MarginContainer/ImageAndTextSeperator/Text/DigsAndRabbithole/Digs.text = " [shake rate=10.0 level=" + str(postPopularity)+ " connected=1]" + str(digs)
	$MarginContainer/ImageAndTextSeperator/Text/Title.text = postTitle
	$MarginContainer/ImageAndTextSeperator/Text/DigsAndRabbithole/RabbitHole.text = "[wave amp=25.0 freq=5.0 connected=1]mall://shovel." + postRabbitHole + ".net"
	


func _on_button_pressed() -> void:
	var newPageInstance = newPage.instantiate()
	Global.CurrentPost = [null, 
		postTitle, 
		$MarginContainer/ImageAndTextSeperator.get_node("Images").ttext,
		$MarginContainer/ImageAndTextSeperator.get_node("Images").btext, 
		$MarginContainer/ImageAndTextSeperator.get_node("Images").meme, 
		postRabbitHole,
		postPopularity,
		digs,
		opinion,
		$MarginContainer/ImageAndTextSeperator.get_node("Images").memeColor]
	window = Window.new()
	window.visible = false
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN 
	window.size = Vector2(500, 500)
	window.title = postTitle
	window.close_requested.connect(_on_window_close_requested)
	add_child(window)
	if window.get_child_count() == 0:
		window.add_child(newPageInstance)
	window.visible = true


func _on_window_close_requested() -> void:
	window.queue_free()
