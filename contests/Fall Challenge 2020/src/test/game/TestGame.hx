package test.game;

using buddy.Should;

class TestGame extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Game", {
			it( "test INPUT_ACTIONS_1", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_1 );
				// trace( commands );
				commands.should.be( "BREW 51" );
			});
			
			it( "test INPUT_ACTIONS_2", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_2 );
				// trace( commands );
				commands.should.be( "BREW 52, BREW 51" );
			});

			it( "test INPUT_ACTIONS_3", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_3 );
				// trace( commands );
				commands.should.be( "BREW 53, BREW 52, BREW 51" );
			});
			
			it( "test INPUT_ACTIONS_4", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_4 );
				// trace( commands );
				commands.should.be( "BREW 56, BREW 55, BREW 54, BREW 53, BREW 52, BREW 51" );
			});

			it( "test INPUT_ACTIONS_5", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_5 );
				// trace( commands );
				commands.should.be( "CAST 78, BREW 52, BREW 51" );
			});

			it( "test INPUT_ACTIONS_6", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_6 );
				// trace( commands );
				commands.should.be( "CAST 78, CAST 79, BREW 52, REST, CAST 79, BREW 51" );
			});
			
			it( "test INPUT_ACTIONS_7", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_7 );
				// trace( commands );
				commands.should.be( "CAST 78, REST, CAST 78, BREW 51" );
			});
			
			it( "test INPUT_ACTIONS_8", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_8 );
				// trace( commands );
				commands.should.be( "LEARN 88, CAST 88, BREW 51" );
			});

			it( "test INPUT_ACTIONS_9", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_9 );
				// trace( commands );
				commands.should.be( "LEARN 88, CAST 88, BREW 51" );
			});

			it( "test INPUT_ACTIONS_10", {
				final commands = CreateGameCommands.create( Inputs.INPUT_ACTIONS_10 );
				// trace( commands );
				commands.should.be( "CAST 78 3, BREW 51" );
			});

		});
	}
}