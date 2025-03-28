extends Node

var username = "pussySlayer6969"
var password = "jamesbrown"
var myPosts = {}
var myReplies = {}
var myDMs = {}
var myMoney : int = 600
var howManyPostsPerPage = 60

#Randomizer

var noun : String = "Wizards"
var politicalParty : String = "abraxas"
var person : String = "Dean Winchester"
var stock : String = "LORD"
var verb : String = "copes"
var rabbithole : String = "pornography"
#stockmarkets = NAME : FULL NAME, 
#DESCRIPTION, 
#PRICE, 
#USUAL MONEY CHANGE, 
#RANDOM FACTOR, 
#STATUS: 0 = DEAD, 1 = RISING, -1 = FALLING,
# MAV VALUE (6)
# MIN VALUE (7)
# CurrentStocksPurchased (8)
var stockmarkets : Dictionary = {
	"UNIFUND" : ["Universal Fund", "The ammount of funds supplied to every citezen at the end of the month.", 100, 1, 1, randi_range(-1, 1), 100, 0, 0],
	"LORD" : ["Leisure Orifices & Repugnant Dicks", "World's biggest sex shop, home of the world's biggest vibrator and the ASSFUCKER-94.", 1500, 4, 3, randi_range(-1, 1), 1500, 0, 0],
	"CANDY" : ["ElectricLarryLand", "Pharmacy. Usually gives away weed or steroids from misorders.", 1080, 3, 6, randi_range(-1, 1), 1500, 0, 0],
	"MOTH" : ["Moth Resevoir", "Big box full of the last remaining moths of society, used in scientic experiments.", 450, 45, 15, randi_range(-1, 1), 800, 0, 0],
	"GAYSEX" : ["Sovereign Associates Of Gay Sex", "These men and women decided to fight for the right to GAY SEX. I never noticed it until it was gone!", 5000, 1, 4, randi_range(-1, 1), 7000, 0, 0],
	"MARROONCROSS" : ["Marroon Cross Ltd.", "The world healthcare association. They get payed to sit on their ass and play with their nose.", 30, 5, 50, -1, 400, -400, 0],
	"HATRED" : ["Hatred Industries", "The company that owns shovel.", 300000000, 5, 50, 1, 300045000, 0, 0],
	"INCELDOM" : ["Inceldom Registered Trademark", "Pays women to not fuck men they were already not going to fuck because their shower is broken for the seventh time this week.", 450525, 100, 75, randi_range(-1, 1), 500000, 0, 0],
	"BREAKDOWN" : ["Breakdown Clinic", "Fuck if I know. I get dizzy looking at it.", 10, 700, 400, randi_range(-1, 1), 700, 0, 0],
	"CIGARETTES" : ["Cigarretes By WIRE", "Nicotine, the core of the soul", randi_range(300, 700), 40, 50, 1, 700, 0, 0],
	"METHINDUSTRIES" : ["Meth Industries", "The harbinger of methamphetamine.", 1500, 80, 90, 1, 3000, -1500, 0],
	"TRANSMYCELIUM" : ["Trans Mycelium Experimentation", "The mushrooms are turning your kids trans, I won't tell you how to feel about this.", 450, 20, 20, randi_range(-1, 1), 500, -500, 0],
	"NIMBLER" : ["United Nimblers Of The Architects", "What's more racist than being racist? NIMBLER!", 450, 20, 20, randi_range(-1, 1), 500, -500, 0],
	"JARVISIVRAJ" : ["JarvisivraJ", "A CEO who's very narcissist, but let's be honest, which ones arent'?", 600000000, 70, 90, randi_range(-1, 1), 700000000, 0, 0],
	"REMAINSOFBRAZIL" : ["Remains Of Brazil", "No one cares anymore, sad for some I guess.", 10, 0, 0, 0, 0, 0, 0]
}

var stocksHistory : Dictionary = {
	"UNIFUND" : [],
	"LORD" : [],
	"CANDY" : [],
	"MOTH" : [],
	"GAYSEX" : [],
	"MARROONCROSS" : [],
	"HATRED" : [],
	"INCELDOM" : [],
	"BREAKDOWN" : [],
	"CIGARETTES" : [],
	"METHINDUSTRIES" : [],
	"TRANSMYCELIUM" : [],
	"NIMBLER" : [],
	"JARVISIVRAJ" : [],
	"REMAINSOFBRAZIL" : [],
}

var currentStockSelected = "UNIFUND"
#SavedPostWhenClicked
var memeClicked = null
var ttextClicked = null
var btextClicked = null

#CurrentPost - User, Post Title, Top Text, Bottom Text, Meme, RabbitHole, Post Popularity, Digs, Opinion, Color
var CurrentPost = [null, """"WIZARD MAGIC" Bio-slave says.""", "CEO MINDSET AFFECTS", "TRANSGENDERED MICE", 1, "48hourworkday", 5, 3405, -1, Color(Color.AQUA)]

func _ready() -> void:
	randomize()

func getNoun():
	var file = "user://nouns.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		noun = str(list.get_line().to_lower())
		if rng.randi() % 10 == 0:
			return
	
func getPoliticalParty():
	var file = "user://politicalparties.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		politicalParty = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
			
func getPerson():
	var file = "user://people.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		person = str(list.get_line())
		if rng.randi() % 10 == 0:
			return

func getStocks():
	var file = "user://stocks.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		stock = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
			
func getVerb():
	var file = "user://verbs.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		
		verb = str(list.get_line())
		if rng.randi() % 10 == 0:
			return
			
func getRabbitHole():
	var file = "user://rabbitholes.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		rabbithole = str(list.get_line().to_lower())
		if rng.randi() % 10 == 0:
			return
			


func randomizeString(rstr : String, letterCase) -> String:
	if rstr.is_empty() == false:
		if "/noun/" in rstr:
			getNoun()
			rstr = rstr.replacen("/noun/", noun)
		if "/pp/" in rstr:
			getPoliticalParty()
			rstr = rstr.replacen("/pp/", politicalParty)
		if "/people/" in rstr:
			getPerson()
			rstr = rstr.replacen("/people/", person)
		if "/stocks/" in rstr:
			getStocks()
			rstr = rstr.replacen("/stocks/", stock)
		if "/verb/" in rstr:
			getVerb()
			rstr = rstr.replacen("/verb/", verb)
		if "/memeclickedtop/" in rstr:
			rstr = rstr.replacen("/memeclickedtop/", Global.CurrentPost[2])
		if "/memeclickedbottom/" in rstr:
			rstr = rstr.replacen("/memeclickedbottom/", Global.CurrentPost[3])
		if "/rabbithole/" in rstr:
			rstr = rstr.replacen("/rabbithole/", rabbithole)
		if "/number/" in rstr:
			rstr = rstr.replacen("/number/", str(randi_range(0, 9)))
		if "/number2/" in rstr:
			rstr = rstr.replacen("/number2/", str(randi_range(10, 99)))
		if letterCase:
			var letterStatus = randi_range(1, 6)
			match letterStatus:
				1:
					rstr = rstr.to_lower()
				4:
					rstr = rstr.to_camel_case()
				5:
					rstr = rstr.capitalize()
				6:
					rstr = rstr.to_upper()
		
		return rstr
	else:
		return "YOU FUCKED UP"
