package test.tunnel;

import BreadthFirstSearch;
import data.Node;
import haxe.display.JsonModuleTypes.JsonDoc;
import parser.ParseLevel;

using Lambda;
using buddy.Should;

@:access(Main)
class TestGetRotationPaths extends buddy.BuddySuite {


	public function new() {
		
		describe( "Test Tunnel getRotationPaths", {
			
			it( "Broken Well", {
				final input = brokenWell;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startNode:Node = { index: input.indy.index, pos: input.indy.pos };
				final paths = breadthFirstSearch( startNode, tunnel, input.cells, input.exit );
				final rotationPaths = paths.flatMap( path -> tunnel.getRotationPaths( path, input.cells ));
				// trace( "\n" + rotationPaths.map( path -> path.map( node -> 'index ${node.index} rot ${node.tile}' ).join(" ")).join( "\n" ));
				rotationPaths.length.should.be( 1 );
			});	
			@include
			it( "Broken Well2", {
				final input = brokenWell2;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final startNode:Node = { index: input.indy.index, pos: input.indy.pos };
				final paths = breadthFirstSearch( startNode, tunnel, input.cells, input.exit );
				final rotationPaths = paths.flatMap( path -> tunnel.getRotationPaths( path, input.cells ));
				trace( "\n" + rotationPaths.map( path -> path.map( node -> 'index ${node.index} tile ${node.tile}' ).join(" ")).join( "\n" ));
				rotationPaths.length.should.be( 2 );
			});	
			
		});
		
	}

	final brokenWell = parseLevel(
	"5 3
	0 0 -3 0 0
	0 0 2 0 0
	0 0 -3 0 0
	2
	2 0 TOP
	0" );
	
	final brokenWell2 = parseLevel(
	"5 3
	0 0 -3 0 0
	0 0 6 0 0
	0 0 -3 0 0
	2
	2 0 TOP
	0" );

}

