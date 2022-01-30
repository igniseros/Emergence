extends Node2D
#todo - figure how to extend
var XD = {"dot" : Dot, "wall" : WallDot, "food" : FoodDot, "crawl" : CrawlDot}
var COLOR = {Color("#757574") : WallDot, Color("#ffff00") : FoodDot, Color("#ff00ff") : CrawlDot, Color("#f087f3") : CrawlFriendDot,
Color("#b6ff67") : NativeLifeDot}

func add_color_connection(color,dot):
	COLOR[color] = dot
