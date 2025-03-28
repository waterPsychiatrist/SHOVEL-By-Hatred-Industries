extends Control
var username : String = ""
var commentText : String = ""
var opinion : String = "positive"
var isPlayerComment = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Randomize Profile Picture
	if isPlayerComment == false:
		var pfpRandomizer = randi_range(1, 3)
		$MarginContainer/ImageAndTextSeperator/ProfilePicture.texture = load("res://Graphics/Images/ProfilePictures/" + str(pfpRandomizer) + ".png")
		pfpRandomizer = randi_range(1, 4)
		match pfpRandomizer:
			2:
				$MarginContainer/ImageAndTextSeperator/ProfilePicture.flip_h = true
			2:
				$MarginContainer/ImageAndTextSeperator/ProfilePicture.flip_v = true
			4:
				$MarginContainer/ImageAndTextSeperator/ProfilePicture.flip_h = true
				$MarginContainer/ImageAndTextSeperator/ProfilePicture.flip_v = true
		$MarginContainer/ImageAndTextSeperator/ProfilePicture.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
		
		#getOpinion
		var rngOpinion = randi_range(0, 10)
		if rngOpinion != 0:
			if Global.CurrentPost[8] == 1:
				if rngOpinion >= 4:
					opinion = "positive"
				else:
					opinion = "negative"
			if Global.CurrentPost[8] == -1:
				if rngOpinion >= 4:
					opinion = "negative"
				else:
					opinion = "positive"
		else:
			opinion = "negative"
		
		#Comment Randomize
		getComment()
		$MarginContainer/ImageAndTextSeperator/Text/Comment.text = Global.randomizeString(commentText, true)
		getUser()
		$MarginContainer/ImageAndTextSeperator/Text/Username.text = Global.randomizeString(username, false).to_lower().replacen(" ", "")
	else:
		#var playerPFP = ImageTexture.create_from_image("user://images/pfp.png")
		var image = Image.load_from_file("user://images/pfp.png")
		var playerPFP = ImageTexture.create_from_image(image)
		$MarginContainer/ImageAndTextSeperator/ProfilePicture.texture = playerPFP
		
		$MarginContainer/ImageAndTextSeperator/Text/Comment.text = Global.myReplies.keys()[-1]
		$MarginContainer/ImageAndTextSeperator/Text/Username.text = Global.username
		

func getComment():
	var file = "user://comments" + opinion + ".txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		commentText = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
func getUser():
	var file = "user://usernames.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		username = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
	
