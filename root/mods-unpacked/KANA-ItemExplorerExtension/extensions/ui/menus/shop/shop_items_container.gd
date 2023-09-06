extends "res://ui/menus/shop/shop_items_container.gd"


func _ready() -> void:
	connect("shop_item_bought", self, "_KANA_on_shop_item_bought")


func set_shop_items(items_data: Array) -> void:
	.set_shop_items(items_data)

	_KANA_updated_viewed_items(items_data)


func _KANA_updated_viewed_items(items_data: Array) -> void:
	for item in items_data:
		if item[0].my_id.begins_with("item"):
			var current_item: Dictionary = ProgressData.data.kana_item_explorer_extension_item_data[item[0].my_id]
			current_item.viewed = current_item.viewed + 1


func _KANA_on_shop_item_bought(shop_item: ShopItem) -> void:
	var current_item: Dictionary = ProgressData.data.kana_item_explorer_extension_item_data[shop_item.item_data.my_id]
	current_item.bought = current_item.bought + 1
