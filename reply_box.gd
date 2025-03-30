extends Control
var comment = load("res://Comment.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rngPlaceholderText = [
		"Write the next big take.",
		"What do you see here?",
		"Opinions? Thoughts?",
		Global.randomizeString("This probably relates to /noun/, anyways write your comment.", false),
		"Gaze upon this shit, ain't it stupid?",
		"Does this make you angry? Describe why.",
		"Write about how this guy fucked your husband/wife/other.",
		"This is insane. You HAVE to write a comment!",
		"What's on your mind?",
		"Don't comment anything related to the post here.",
		"Write text here!"
	]
	$ReplyBox/MarginContainer/ImageAndTextSeperator/ScrollContainer/Text/TextEdit.placeholder_text = rngPlaceholderText.pick_random()
	var image = Image.load_from_file("user://images/pfp.png")
	var playerPFP = ImageTexture.create_from_image(image)
	$ReplyBox/MarginContainer/ImageAndTextSeperator/ProfilePicture.texture = SaveDataManager.getProfilePicture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_newline") && $ReplyBox/MarginContainer/ImageAndTextSeperator/ScrollContainer/Text/TextEdit.text.replacen(" ", "") != "":
		var currentTime = Time.get_datetime_string_from_system().replace("T", " | ")
		Global.myReplies.merge({currentTime + ": " + $ReplyBox/MarginContainer/ImageAndTextSeperator/ScrollContainer/Text/TextEdit.text : Global.CurrentPost})
		$ReplyBox/MarginContainer/ImageAndTextSeperator/ScrollContainer/Text/TextEdit.clear()
		var commentInst = comment.instantiate()
		commentInst.name = "PlayerReply"
		commentInst.isPlayerComment = true
		self.add_child(commentInst)
		self.move_child(self.get_child(-1), 1)
		
