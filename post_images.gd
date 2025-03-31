extends Control
var isBeingRandomlyMade = null
var currentFile = ""
var meme : int = 1
var ttext : String = ""
var btext : String = ""
var memeColor : Color = Color(Color.WHITE)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isBeingRandomlyMade == true:
		meme = randi_range(1, 23)
		$Meme.texture = load("res://Graphics/Images/Memes/" + str(meme) + ".png")
		ttext = Global.randomizeString(Global.getFromTXTFile("memetoptext"), false).to_upper()
		btext = Global.randomizeString(Global.getFromTXTFile("memebottomtext"), false).to_upper()
		memeColor = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)

	elif isBeingRandomlyMade == false:
		meme = Global.CurrentPost[4]
		ttext = "[font_size=48]" + Global.CurrentPost[2]
		btext = "[font_size=48]" + Global.CurrentPost[3]
		$Meme.texture = load("res://Graphics/Images/Memes/" + str(meme) + ".png")
		memeColor = Global.CurrentPost[9]
	$TopTextLabel.text = ttext
	$BottomTextLabel.text = btext
	$Meme.modulate = memeColor
	#$TopText.texture = load("res://Graphics/Images/Memes/TopText/" + str(ttext) + ".png")
	#$BottomText.texture = load("res://Graphics/Images/Memes/BottomText/" + str(btext) + ".png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
