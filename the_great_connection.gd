extends Node2D
#todo - figure how to extend
var XD = {"dot" : Dot, "wall" : WallDot, "food" : FoodDot, "crawl" : CrawlDot}
var COLOR = {Color("#757574") : WallDot, Color("#ffff00") : FoodDot, Color("#ff00ff") : CrawlDot, Color("#f087f3") : CrawlFriendDot,
Color("#b6ff67") : NativeLifeDot, Color("#ffb41e"): GeneratorFoodDot, Color("#ff0000") : KillerWallDot, Color("ff0080") : KillerCrawlDot, Color("ff6c80"): KillerCrawlFriendDot,
Color("#000000") : EvolvingLifeDot}

func add_color_connection(color,dot):
	COLOR[color] = dot
