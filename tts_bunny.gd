extends Control
var voiceLine = "nothing"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if OS.is_debug_build() and Input.is_action_just_pressed("ui_home"):
		slide(2)
	
func slide(whichDir : int) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(2).timeout
	speak()
	
func speak():
	$BunnyAnim.play("Talking")
	#var TTSSOCallable = Callable(self, "ttsSpeechOver")
	DisplayServer.tts_set_utterance_callback(DisplayServer.TTS_UTTERANCE_ENDED, ttsSpeechOver)
	DisplayServer.tts_speak(voiceLine, DisplayServer.tts_get_voices()[0]["id"])
func ttsSpeechOver():
	$BunnyAnim.play("Idle")
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", Vector2(0, 1024), 1).set_trans(Tween.TRANS_SINE)
	
