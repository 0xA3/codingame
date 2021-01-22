package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Test 1", {
				Main.process( 12 ).should.be( parseResult(
					"0 0 4
					2 1 0"
				));
			});
			
			it( "Test 2", {
				Main.process( 15 ).should.be( parseResult(
					"0 0 5
					2 1 1
					3 0 0"
				));
			});
			
			it( "Test 3", {
				Main.process( 21 ).should.be( parseResult(
					"0 0 7
					2 1 3
					3 0 2
					3 3 0"
				));
			});
			
			it( "Test 4", {
				Main.process( 88 ).should.be( parseResult(
					"1 1 27
					2 0 26
					3 2 23
					4 1 22
					4 4 20
					5 0 21
					5 3 19
					6 2 18
					6 5 16
					7 1 17
					7 4 15
					7 7 13
					8 0 16
					8 3 14
					8 6 12
					9 2 13
					9 5 11
					9 8 9
					10 1 12
					10 4 10
					10 7 8
					10 10 6
					11 0 11
					11 3 9
					11 6 7
					11 9 5
					12 2 8
					12 5 6
					12 8 4
					12 11 2
					13 1 7
					13 4 5
					13 7 3
					13 10 1
					14 0 6
					14 3 4
					14 6 2
					14 9 0
					15 2 3
					15 5 1
					16 1 2
					16 4 0
					17 0 1"
				));
			});
			
		});

	}

	static function parseResult( s:String ) {
		return s.replace( "\t", "" ).replace( "\r", "" );
	}

}

