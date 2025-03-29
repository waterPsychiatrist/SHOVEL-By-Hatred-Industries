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
		commentText = Global.randomizeString(Global.getFromTXTFile("comments" + str(opinion)), true)
		$MarginContainer/ImageAndTextSeperator/Text/Comment.text = Global.randomizeString(commentText, true)
		username = Global.randomizeString(Global.getFromTXTFile("usernames"), true)
		$MarginContainer/ImageAndTextSeperator/Text/Username.text = Global.randomizeString(username, false).to_lower().replacen(" ", "")
	else:
		#var playerPFP = ImageTexture.create_from_image("user://images/pfp.png")
		var image = Image.load_from_file("user://images/pfp.png")
		var playerPFP = ImageTexture.create_from_image(image)
		$MarginContainer/ImageAndTextSeperator/ProfilePicture.texture = playerPFP
		
		$MarginContainer/ImageAndTextSeperator/Text/Comment.text = Global.myReplies.keys()[-1]
		$MarginContainer/ImageAndTextSeperator/Text/Username.text = Global.username
		
