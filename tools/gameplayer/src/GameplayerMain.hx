import gameplayer.Gameplayer;
import hxd.Window;

class GameplayerMain extends hxd.App {

	var gameplayer:Gameplayer;

	static function main() {
		hxd.Res.initEmbed();
		new GameplayerMain();
	}

	override function init() {
		gameplayer = new Gameplayer( s2d, Window.getInstance() );
		gameplayer.init();

		gameplayer.maxFrame = 10;
	}

	override function update( dt:Float ) {
		gameplayer.update( dt );
	}
}