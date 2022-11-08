package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "Test1", { Main.process( "CakE;102,108,111,117,114+101,103,103,115+109,105,108,107" ).should.be( "Cake ingredients are flour, eggs, milk" ); });
			it( "Test2", { Main.process( "MANsaf;114,105,99,101+106,97,109,101,101,100+108,97,109,112" ).should.be( "Mansaf ingredients are rice, jameed, lamp" ); });
			it( "Test3", { Main.process( "PiZzA;100,111,117,103,104+109,111,122,122,97,114,101,108,108,97+116,111,109,97,116,111+107,101,116,99,104,117,112+112,101,112,112,101,114,111,110,105" ).should.be( "Pizza ingredients are dough, mozzarella, tomato, ketchup, pepperoni" ); });
			it( "Test4", { Main.process( "SaNdWich;98,114,101,97,100+99,104,101,101,115,101+109,111,114,116,97,100,101,108,108,97" ).should.be( "Sandwich ingredients are bread, cheese, mortadella" ); });
		});
	}
}
