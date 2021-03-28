package test.tunnel;

import BreadthFirstSearch;
import data.Node;
import haxe.display.JsonModuleTypes.JsonDoc;
import parser.ParseLevel;

using Lambda;
using buddy.Should;

@:access(Main)
class TestGetRotations extends buddy.BuddySuite {


	public function new() {
		
		describe( "Test Tunnel getRotations", {
			
			it( "Longer Broken Well", {
				final input = longerBrokenWell;
				final tunnel = new Tunnel( input.locked, input.width );
				final startNode:Node = { index: input.indy.index, pos: input.indy.pos };
				final paths = breadthFirstSearch( startNode, [], tunnel, input.cells, input.exit );
				final pathsRotations = paths.map( path -> tunnel.getRotations( path, input.cells ));
				pathsRotations.length.should.be( 1 );
				pathsRotations[0].length.should.be( 2 );
				pathsRotations[0].map( rotation -> rotation.value ).join(" ").should.be( "0 1" );
			});	
			
			it( "Initial Double Rotate", {
				final input = initialDoubleRotate;
				final tunnel = new Tunnel( input.locked, input.width );
				final startNode:Node = { index: input.indy.index, pos: input.indy.pos };
				final paths = breadthFirstSearch( startNode, [], tunnel, input.cells, input.exit );
				final pathsRotations = paths.map( path -> tunnel.getRotations( path, input.cells ));
				pathsRotations.length.should.be( 1 );
				pathsRotations[0].length.should.be( 2 );
				pathsRotations[0].map( rotation -> rotation.value ).join(" ").should.be( "2 0" );
			});	
			
			it( "Later Double Rotate", {
				final input = laterDoubleRotate;
				final tunnel = new Tunnel( input.locked, input.width );
				final startNode:Node = { index: input.indy.index, pos: input.indy.pos };
				final paths = breadthFirstSearch( startNode, [], tunnel, input.cells, input.exit );
				final pathsRotations = paths.map( path -> tunnel.getRotations( path, input.cells ));
				pathsRotations.length.should.be( 1 );
				pathsRotations[0].length.should.be( 2 );
				pathsRotations[0].map( rotation -> rotation.value ).join(" ").should.be( "0 2" );
			});	
			
		});
		
	}

	final longerBrokenWell = parseLevel(
	"5 4
	0 0 -3 0 0
	0 0 3 0 0
	0 0 2 0 0
	0 0 -3 0 0
	2
	2 0 TOP
	0" );
	
	final initialDoubleRotate = parseLevel(
	"5 3
	0 0 -3 0 0
	0 0 13 -13 0
	0 0 0 -3 0
	3
	2 0 TOP
	0" );
	
	final laterDoubleRotate = parseLevel(
	"5 3
	0 0 -3 0 0
	0 0 11 11 0
	0 0 0 -3 0
	3
	2 0 TOP
	0" );
	
}

