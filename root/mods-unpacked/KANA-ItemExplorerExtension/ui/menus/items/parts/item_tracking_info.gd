extends PanelContainer


onready var label_view_count: Label = $"%Label_View_Count"
onready var label_bought_count: Label = $"%Label_Bought_Count"


func init(item_tracking_data: Dictionary) -> void:
	label_view_count.text = str(item_tracking_data.viewed)
	label_bought_count.text = str(item_tracking_data.bought)
