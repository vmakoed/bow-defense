extends Node
#TODO: move all sfx audio here


@export var audio_bus : StringName = &"SFX"


func play_audio(stream: AudioStream) -> void:
    var player = AudioStreamPlayer.new()
    player.stream = stream
    player.bus = audio_bus
    add_child(player)
    player.finished.connect(func(): player.queue_free())
    player.play()
