import gameplayer.Gameplayer;
import hxd.Window;

class Main extends hxd.App {

	var gamePlayer:Gameplayer;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}

	override function init() {
		gamePlayer = new Gameplayer( s2d, Window.getInstance() );
		gamePlayer.init();	
		
	}

	
}