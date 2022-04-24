package game;

class MainGame {
	
	static var app:game.App;

	static function main() {
		hxd.Res.initEmbed();
		app = new game.App();
		
		app.initComplete.handle(() -> startSimulation());
	}

	static function startSimulation() {
		final referee = new game.Referee();
		referee.init( 0 );
		
		referee.frameDataset.handle( d -> app.addFrameViewData( d ));

		referee.run();
	}
}