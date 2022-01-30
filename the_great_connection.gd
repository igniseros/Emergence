class_name TheGreatConnection
#todo - figure how to extend
const XD = {"dot" : Dot, "wall" : WallDot, "food" : FoodDot, "crawl" : CrawlDot}
const COLOR = {Color("#757574") : WallDot, Color("#ffff00") : FoodDot, Color("#ff00ff") : CrawlDot, Color("#f087f3") : CrawlFriendDot}

static func add_color_connection(color,dot):
	COLOR[color] = dot
