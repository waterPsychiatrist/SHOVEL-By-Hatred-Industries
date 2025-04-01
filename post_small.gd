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
var isWindowShown = false
#There are 5 types of post popularity: 1 - Who cares | 2 - Some People | 3 - Normal Post | 4 - Quite Popular | 5 - Industry Moving

func _ready() -> void:
	var imageInst = image.instantiate()
	imageInst.isBeingRandomlyMade = true
	$MarginContainer/ImageAndTextSeperator.add_child(imageInst)
	$MarginContainer/ImageAndTextSeperator.move_child(get_node("MarginContainer/ImageAndTextSeperator/Images"), 0)
	makePost()
# Called every frame. 'delta' is the elapsed time since the previous frame.

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
	
	#getRabbitHole()
	postRabbitHole = Global.randomizeString(Global.getFromTXTFile("rabbitholes"), false, true).to_lower()
	#getTitle()
	postTitle = Global.randomizeString(Global.getFromTXTFile("titles"), true)
	$MarginContainer/ImageAndTextSeperator/Text/DigsAndRabbithole/Digs.text = " [shake rate=10.0 level=" + str(postPopularity)+ " connected=1]" + str(digs)
	$MarginContainer/ImageAndTextSeperator/Text/Title.text = "[font_size=" + str(Global.textSize) + "]" + postTitle
	$MarginContainer/ImageAndTextSeperator/Text/DigsAndRabbithole/RabbitHole.text = "[wave amp=25.0 freq=5.0 connected=1]mall://shovel." + postRabbitHole.to_lower().replacen(" ", "").replacen(".", "") + ".net"
	


func _on_button_pressed() -> void:
	if isWindowShown == false:
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
			$MarginContainer/ImageAndTextSeperator.get_node("Images").memeColor
			]
		window = Window.new()
		window.visible = false
		window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN 
		window.size = Vector2(1280, 1024)
		window.title = postTitle
		window.content_scale_mode = 2
		window.content_scale_aspect = 1
		window.size = Global.windowSize
		window.content_scale_size = Global.windowSize
		window.close_requested.connect(_on_window_close_requested)
		window.add_to_group("SubWindowNodes")
		add_child(window)
		window.add_child(newPageInstance)
		window.visible = true
		isWindowShown = false


func _on_window_close_requested() -> void:
	isWindowShown = true
	window.queue_free()
