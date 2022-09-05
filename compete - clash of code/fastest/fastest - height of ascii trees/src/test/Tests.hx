package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", {
				final ip = test1;
				Main.process( ip.t, ip.g, ip.h, ip.rows ).should.be( "20 22" ); });
			it( "Test2", {
				final ip = test2;
				Main.process( ip.t, ip.g, ip.h, ip.rows ).should.be( "3997 3999 3998" ); });
			it( "Test3", {
				final ip = test3;
				Main.process( ip.t, ip.g, ip.h, ip.rows ).should.be( "124 121 122 125 122" ); });
			it( "Test4", {
				final ip = test4;
				Main.process( ip.t, ip.g, ip.h, ip.rows ).should.be( "10 13 12 13 11 13 13 11 9" ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final t = parseInt( lines[0] );
		final g = parseInt( lines[1] );
		final h = parseInt( lines[2] );
		final rows = [for( i in 0...h ) lines[i + 3]];

		return { t: t, g: g, h: h, rows: rows }
	}

	static final test1 = parseInput(
	"6
	3
	4
	  #
	  #
	# #
	# #" );

	static final test2 = parseInput(
	"999
	4
	3
	  #  
	  # #
	# # #" );

	static final test3 = parseInput(
	"120
	1
	5
	      #  
	#     #  
	#     #  
	#   # # #
	# # # # #" );

	static final test4 = parseInput(
	"2
	4
	5
	  #   #   # #    
	  # # #   # #    
	  # # # # # # #  
	# # # # # # # #  
	# # # # # # # # #" );
}
