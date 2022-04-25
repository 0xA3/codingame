package game;

class MainGame {
	
	static var app:player.App;

	static function main() {
		hxd.Res.initEmbed();
		app = new player.App();
		
		app.initComplete.handle(() -> startSimulation());
	}

	static function startSimulation() {
		final referee = new game.Referee();
		referee.init( 0 );
		
		referee.frameDataset.handle( d -> app.addFrameViewData( d ));

		referee.runWithTimer();
	}
}