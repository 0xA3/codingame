package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Example", Main.process( "Wooden Sword,Common,Damage:20" ).should.be( exampleResult ));
			it( "Increased rarity", Main.process( "Iron Pickaxe,Rare,Speed:5,Damage:5,Crit. Chance:1.2%" ).should.be( increasedRarityResult ));
			it( "Epic now?", Main.process( "Draconic Sword,Epic,Skill:Dragon Cry,Damage:100,Critical Damage:150%" ).should.be( epicNowResult ));
			it( "Let's Legendary!", Main.process( "Sword of Everything,Legendary,Skill:Annihilation,Skill:Creation,Damage:500,Critical Chance:3.5%,Critical Damage:300%,Speed:2" ).should.be( letSLegendaryResult ));
			it( "Another one, just for fun", Main.process( "Elucidator,Legendary,Skill:Dual Blades,Damage:150,Speed:15,Critical Chance:5.1%,Critical Damage:450%" ).should.be( anotherOneJustForFunResult ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final exampleResult = parseResult(
		"##################
		# -Wooden Sword- #
		#     Common     #
		# Damage 20      #
		##################"
	);

	final increasedRarityResult = parseResult(
		"/###################\\
		#   -Iron Pickaxe-  #
		#        Rare       #
		# Speed 5           #
		# Damage 5          #
		# Crit. Chance 1.2% #
		\\###################/"
	);

	final epicNowResult = parseResult(
		"/----------------------\\
		|   -Draconic Sword-   |
		|         Epic         |
		| Skill Dragon Cry     |
		| Damage 100           |
		| Critical Damage 150% |
		\\______________________/"
	);

	final letSLegendaryResult = parseResult(
		"X----------\\_/----------X
		[ -Sword of Everything- ]
		|       Legendary       |
		| Skill Annihilation    |
		| Skill Creation        |
		| Damage 500            |
		| Critical Chance 3.5%  |
		| Critical Damage 300%  |
		| Speed 2               |
		X_______________________X"
	);

	final anotherOneJustForFunResult = parseResult(
		"X---------\\__/---------X
		[     -Elucidator-     ]
		|       Legendary      |
		| Skill Dual Blades    |
		| Damage 150           |
		| Speed 15             |
		| Critical Chance 5.1% |
		| Critical Damage 450% |
		X______________________X"
	);
}
