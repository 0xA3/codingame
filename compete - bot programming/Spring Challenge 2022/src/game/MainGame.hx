package game;

class MainGame {
	
	static var referee:game.Referee;
	static var app:game.App;

	static function main() {
		hxd.Res.initEmbed();
		referee = new game.Referee();
		app = new game.App();

		referee.frameDataset.handle( d -> app.addFrameViewData );

		referee.init( 0 );
		referee.run();
	}

}