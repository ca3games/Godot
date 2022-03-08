extends GridContainer

func CleanSelection():
	var name = "Item"
	for i in 6:
		name = "Item" + str(i)
		get_node(name).SelectOFF()

func SetItem(id, ammo):
	var name = "Item"
	name = "Item" + str(id)
	get_node(name).SetItem(id)

func UpdateAMMO(id):
	var name = "Item"
	name = "Item" + str(id)
	get_node(name).UpdatePic()

func SetActive(id):
	var name = "Item"
	name = "Item" + str(id)
	get_node(name).SetActive()

func TurnH(id):
	var name = "Item" + str(id)
	get_node(name).SelectON()
