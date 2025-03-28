extends Control
var image = load("res://PostImages.tscn")
var replyBox = load("res://reply_box.tscn")
var comments = load("res://Comment.tscn")
var howManyComments = 0
var currentlyLoadedComments = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var imageInst = image.instantiate()
	imageInst.isBeingRandomlyMade = false
	imageInst.custom_minimum_size = Vector2(120, 120) * 4
	$MarginContainer/PageScroll/PageVBox.add_child(imageInst)
	howManyComments = (Global.CurrentPost[6] * randi_range(7, 18)) + randi_range(1, 9)
	if howManyComments < 0:
		howManyComments *= -1
	print(howManyComments)
	$CanvasLayer/Control/Title.text = Global.CurrentPost[1]
	$CanvasLayer/Control/RabbitHole.text = Global.CurrentPost[5]
	var replyBoxInst = replyBox.instantiate()
	$MarginContainer/PageScroll/PageVBox.add_child(replyBoxInst)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if currentlyLoadedComments < howManyComments:
		var commentsInst = comments.instantiate()
		$MarginContainer/PageScroll/PageVBox.add_child(commentsInst)
		currentlyLoadedComments += 1
