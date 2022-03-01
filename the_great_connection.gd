extends Node2D
#todo - figure how to extend
var XD = {"dot" : Dot, "wall" : WallDot, "food" : FoodDot, "crawl" : CrawlDot}
var COLOR = {Color("#757574") : WallDot, Color("#ffff00") : FoodDot, Color("#ff00ff") : CrawlDot, Color("#f087f3") : CrawlFriendDot,
Color("#b6ff67") : HerbavoreEvolvingLifeDot, Color("#ffb41e"): GeneratorFood2Dot, Color("#ff0000") : CarnivoreEvolvingLifeDot, Color("ff0080") : KillerCrawlDot, Color("ff6c80"): KillerCrawlFriendDot,
Color("#000000") : EvolvingLifeDot, Color("#1b00ff") : AttachableMasterDot, Color("#ffffff") : AttachableFollowerDot}

func add_color_connection(color,dot):
	COLOR[color] = dot
