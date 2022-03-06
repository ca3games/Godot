extends GridContainer

func CleanSelection():
	var name = "Item"
	for i in 6:
		name = "Item" + str(i)
		get_node(name).SelectOFF()

func SetItem(id, gun, ammo):
	var name = "Item"
	name = "Item" + str(id)
	get_node(name).SetItem(gun)

func UpdateAMMO(id):
	print(id)
	var name = "Item"
	name = "Item" + str(id)
	get_node(name).UpdatePic()

func TurnH(id):
	var name = "Item" + str(id)
	get_node(name).SelectON()
