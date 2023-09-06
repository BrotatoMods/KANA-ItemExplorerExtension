extends OptionButton


func init(options: Dictionary) -> void:
	for option_index in options.keys():
		var option: Dictionary = options[option_index]
		add_item(option.text, option_index)
