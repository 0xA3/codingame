package test;

import Main;
import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {

			it( "Broken well", {
				final input = brokenWell;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	
			
			it( "Broken sewer", {
				final input = brokenSewer;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	
			
			it( "Broken secret passages", {
				final input = brokenSecretPassages;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	
			
			it( "Broken mausoleum", {
				final input = brokenMausoleum;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	

			it( "Underground complex", {
				final input = undergroundComplex;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	

			it( "Rocks 1", {
				final input = rocks1;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	

			it( "Rocks 2", {
				final input = rocks2;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				trace( "\n" + tunnel.toString());
				// tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	

		});
	}


	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final brokenWell = parseInput(
		"3 3
		0 3 0
		0 3 0
		0 3 0
		1
		1 0 TOP" );
	
	final wellResult = parseResult(
		"1 1" );
	
	final brokenSewer = parseInput(
		"8 4
		0 -3 0 0 0 0 0 0
		0 12 3 3 2 3 12 0
		0 0 0 0 0 0 2 0
		0 -12 3 2 2 3 13 0
		1
		1 0 TOP" );
	
	final brokenSewerResult = parseResult(
		"1 1" );
	
	final brokenSecretPassages = parseInput(
		"6 9
		0 0 0 0 0 -3
		8 3 3 2 2 10
		2 0 0 0 10 13
		11 3 -2 3 1 13
		-3 10 0 0 2 0
		0 6 3 3 4 13
		0 3 0 13 -4 10
		0 13 2 4 10 0
		0 0 0 -3 0 0
		3
		5 0 TOP" );
	
	final brokenSecretPassagesResult = parseResult(
		"1 1" );
	
	final brokenMausoleum = parseInput(
		"13 10
		-3 12 8 6 3 2 7 2 7 0 0 0 0
		11 5 13 0 0 0 3 0 3 0 0 0 0
		0 11 2 2 3 3 8 2 -9 2 3 13 0
		0 0 0 0 0 12 8 3 1 3 2 7 0
		0 0 11 2 3 1 5 2 10 0 0 11 13
		0 0 3 0 0 6 8 0 0 0 0 0 2
		0 0 11 3 3 10 11 2 3 2 3 2 8
		0 12 6 3 2 3 3 6 3 3 2 3 12
		0 11 4 2 3 2 2 11 12 13 13 13 0
		0 0 -3 12 7 8 13 13 4 5 4 10 0
		2
		0 0 TOP" );
	
	final undergroundComplex = parseInput(
		"13 8
		0 0 0 0 0 0 -3 0 0 0 0 0 0
		0 0 0 8 3 3 5 2 2 8 2 3 13
		0 0 11 5 13 0 3 0 0 3 0 0 2
		0 10 10 0 3 0 2 0 11 4 10 0 2
		0 3 0 0 2 0 2 0 2 0 3 0 3
		0 2 0 12 10 10 1 2 10 0 3 12 10
		12 6 0 2 0 3 2 12 3 3 10 4 -13
		11 -1 2 -6 2 -6 6 -6 2 3 2 -6 -10
		1
		6 0 TOP" );
	
	final rocks1 = parseInput(
		"10 8
		0 0 0 0 0 0 0 0 -3 0
		0 7 -2 3 -2 3 -2 3 11 0
		0 -7 -2 2 2 2 2 2 2 -2
		0 6 -2 2 2 2 2 2 2 -2
		0 -7 -2 2 2 2 2 2 2 -2
		0 8 -2 2 2 2 2 2 2 -2
		0 -7 -2 2 2 2 2 2 2 -2
		0 -3 0 0 0 0 0 0 0 0
		1
		8 0 TOP" );
	
	final rocks2 = parseInput(
		"10 8
		0 -3 0 -3 0 -3 0 -3 -3 0
		0 7 -2 3 -2 2 -2 3 11 0
		0 -7 -2 -2 -2 -2 2 -2 2 -2
		0 6 -2 -2 -2 -2 -2 2 -2 -2
		0 -7 -2 -2 -2 -2 2 -2 2 -2
		0 8 -2 -2 -2 -2 -2 2 -2 -2
		0 -7 -2 -2 -2 -2 2 -2 2 -2
		0 -3 0 0 0 0 0 0 0 0
		1
		8 0 TOP" );
	
}

