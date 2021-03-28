package test.tunnel;

import BreadthFirstSearch;
import data.Node;
import haxe.display.JsonModuleTypes.JsonDoc;
import parser.ParseLevel;

using Lambda;
using buddy.Should;

@:access(Main)
class TestCheckRotations extends buddy.BuddySuite {


	public function new() {
		
		describe( "Test Tunnel checkRotations", {
			
			it( "0 2", {
				final tunnel = new Tunnel( [], 0 );
				tunnel.checkRotations([{ index: 0, value: 0 } , { index: 1, value: 2 }]).should.be( true );
			});	
			
			it( "2 0", {
				final tunnel = new Tunnel( [], 0 );
				tunnel.checkRotations([{ index: 0, value: 2 } , { index: 1, value: 0 }]).should.be( false );
			});	
			
		});
		
	}

}

