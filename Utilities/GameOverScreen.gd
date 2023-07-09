extends Control

var time_remaining = 10
var quarters_remaining = 5
var price_remaining = 50

@onready var tick_sound = load("res://Assets/SFX/timer_tick_collect-5.wav")
@onready var coin_sound = load("res://Assets/SFX/coin-3.wav")

signal continue_game
signal end_game

func _ready():
	set_game_over_timer()
	hide()

func begin():
	$GameOverTimer.start()
	$InsertQuarterTimer.start()
	$ContinuePrice.text = "Insert 50 Cents"
	price_remaining = 50
	time_remaining = 10
	set_game_over_timer()
	$AnimationPlayer.play("RESET")
	show()
	

func _on_game_over_timer_timeout():

	time_remaining -=1
	$AudioStreamPlayer2D.stream = tick_sound
	$AudioStreamPlayer2D.play()
	set_game_over_timer()

func set_game_over_timer():
	$GameOverCountdown.text = String.num_int64(time_remaining).pad_zeros(2)

func _on_insert_quarter_timer_timeout():

	if quarters_remaining > 0:
		# TODO play a sound here
		quarters_remaining -=1
		price_remaining -= 25
		$AudioStreamPlayer2D.stream = coin_sound
		$AudioStreamPlayer2D.play()
		
		if price_remaining > 0:

			$ContinuePrice.text = "Insert 25 Cents"
			$GameOverTimer.start()
			time_remaining = 10
			set_game_over_timer()
		else:
			$ContinuePrice.text = "Insert 00 Cents"
			$GameOverTimer.stop()
			$InsertQuarterTimer.stop()
			continue_game.emit()
			$AnimationPlayer.play("Vanish")
	else:
		print_debug("No more quarters")
		$InsertQuarterTimer.stop()
		end_game.emit()
	


func _on_game_game_over():
	begin()
