package test;
import Main;
using buddy.Should;

@:access(Main)
class TestCases extends buddy.BuddySuite {
	
	static final case1 = [
		'4 4 4 4 4 4 4 4 4 4 4 4 4 4 4',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
		'3 3 3 3 3 3 3 3 3 3 3 3 3 3 3',
		'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
		'2 2 2 2 2 2 2 2 2 2 2 2 2 2 2',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
		'2 2 2 2 2 2 2 2 2 2 2 2 2 2 2',
		'2 2 2 2 2 2 2 2 2 2 2 2 2 2 2',
		'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
		'2 2 2 2 2 2 2 2 2 2 2 2 2 2 2',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
		'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
		'1 1 1 1 1 1 1 1 1 1 1 1 1 1 1'
	];

	public function new() {
		
		describe( "Test Cases", {

			it( "Test getSets", {
				final grid = Main.parseLines( 15, case1 );
				final setter = new Setter( grid.length, grid );
				final sets = setter.getSets();
				// trace( sets );
			});


		});
	}

}