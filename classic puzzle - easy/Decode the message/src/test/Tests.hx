package test;

import haxe.Int64;
import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test encode", {
			it( "Test a", {
				Main.encode( "a", "abcd".split( "" )).should.be( 0 );
			});
			
			it( "Test aa", {
				Main.encode( "aa", "abcd".split( "" ) ).should.be( 4 );
			});

			it( "Test aaa", {
				Main.encode( "aaa", "abcd".split( "" ) ).should.be( 20 );
			});

			it( "Test aaaa", {
				Main.encode( "aaaa", "abcd".split( "" ) ).should.be( 84 );
			});

			// it( "Hello ! World", {
			// 	Main.encode( "Hello ! World", "H_eo: Wrld!".split( "" )).should.be( Int64.parseString( "34170657950616" ));
			// });

		});
		
		describe( "Test process", {
			
			it( "Test a", {
				final input = parseInput(
					"0
					abcd"
				);
				Main.process( input.p, input.c ).should.be( "a" );
			});
			
			it( "Test aa", {
				final input = parseInput(
					"4
					abcd"
				);
				Main.process( input.p, input.c ).should.be( "aa" );
			});
			
			it( "Test aaa", {
				final input = parseInput(
					"20
					abcd"
				);
				Main.process( input.p, input.c ).should.be( "aaa" );
			});
			
			it( "Test aaa", {
				final input = parseInput(
					"84
					abcd"
				);
				Main.process( input.p, input.c ).should.be( "aaaa" );
			});
			
			it( "Test 1", {
				final input = parseInput(
					"35
					abcdefghijklmnopqrstuvwxyz"
				);
				Main.process( input.p, input.c ).should.be( "ja" );
			});
			
			it( "Test 2", {
				final input = parseInput(
					"13484
					abcdefghijklmnopqrstuvwxyz"
				);
				Main.process( input.p, input.c ).should.be( "qxs" );
			});
			
			it( "Test 3", {
				final input = parseInput(
					"132
					ABeDFC"
				);
				Main.process( input.p, input.c ).should.be( "ADe" );
			});
			
			it( "Test 4", {
				final input = parseInput(
					"124
					0123456789"
				);
				Main.process( input.p, input.c ).should.be( "410" );
			});
			
			it( "Test 5", {
				final input = parseInput(
					"155675
					0123456789"
				);
				Main.process( input.p, input.c ).should.be( "565440" );
			});
			
			it( "Test 6", {
				final input = parseInput(
					"34170657950616
					H_eo: Wrld!"
				);
				trace( input.p );

				Main.process( input.p, input.c ).should.be( "Hello ! World" );
			});
			
			it( "Test 7", {
				final input = parseInput(
					"2060735972420674
					abcdefghijklmnopqrstuvwxyz !ABCDEFGHIJKLMNOPQRSTUVWXYZ"
				);
				Main.process( input.p, input.c ).should.be( "Awesome !" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { p: Int64.parseString( lines[0] ), c: lines[1].split( "" ) };
	}

}

