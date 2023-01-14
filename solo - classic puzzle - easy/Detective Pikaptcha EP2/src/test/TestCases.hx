package test;

using buddy.Should;

@:access( Main )
class TestCases extends buddy.BuddySuite {
	
	public function new() {
@include
		describe( "Test cases", {
			it( "Test A small chamber", {
				final maze = new Maze( 5, 3,[
					'>000#',
					'#0#00',
					'00#0#'
				]);
				final follow = -1;
				final initialPosition = maze.getInitialPosition();
				final pikapcha = new Pikapcha( maze, follow, initialPosition);
				final result = Main.play( pikapcha, maze, initialPosition );
				result.join( '' ).should.be(
					"1322#" +
					"#2#31" +
					"12#1#"
				);
			});
			it( "Test Two Chambers", {
				final maze = new Maze( 9, 3,[
					'#00###000',
					'0000<0000',
					'000##0000'
				]);
				final follow = 1;
				final initialPosition = maze.getInitialPosition();
				final pikapcha = new Pikapcha( maze, follow, initialPosition);
				final result = Main.play( pikapcha, maze, initialPosition );
				result.join( '' ).should.be(
					"#11###000" +
					"112210000" +
					"111##0000"
				);
			});


			it( "Test Trapped", {
				final maze = new Maze( 3, 3,[
					'0#0',
					'#>#',
					'0#0'
				]);
				final follow = -1;
				final initialPosition = maze.getInitialPosition();
				maze.increment( initialPosition );
				final pikapcha = new Pikapcha( maze, follow, initialPosition);
				final result = Main.play( pikapcha, maze, initialPosition );
				trace( result );
			});


		});
	}

}