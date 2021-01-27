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
			
			it( "0", {	Main.process( "1000000000000000" ).should.be( "0000000000000000" ); });
			it( "1", {	Main.process( "0100000000000000" ).should.be( "0000000000000000" ); });
			it( "2", {	Main.process( "0010000000000000" ).should.be( "0000000000000000" ); });
			it( "3", {	Main.process( "0001000000000000" ).should.be( "0000000000000000" ); });
			it( "4", {	Main.process( "0000100000000000" ).should.be( "0000000000000000" ); });
			it( "5", {	Main.process( "0000010000000000" ).should.be( "0000000000000000" ); });
			it( "6", {	Main.process( "0000001000000000" ).should.be( "0000000000000000" ); });
			it( "7", {	Main.process( "0000000100000000" ).should.be( "0000000000000000" ); });
			it( "8", {	Main.process( "0000000010000000" ).should.be( "0000000000000000" ); });
			it( "9", {	Main.process( "0000000001000000" ).should.be( "0000000000000000" ); });
			it( "10", {	Main.process( "0000000000100000" ).should.be( "0000000000000000" ); });
			it( "11", {	Main.process( "0000000000010000" ).should.be( "0000000000000000" ); });
			it( "12", {	Main.process( "0000000000001000" ).should.be( "0000000000000000" ); });
			it( "13", {	Main.process( "0000000000000100" ).should.be( "0000000000000000" ); });
			it( "14", {	Main.process( "0000000000000010" ).should.be( "0000000000000000" ); });
			it( "15", {	Main.process( "0000000000000001" ).should.be( "0000000000000000" ); });
			it( "Single bit flipped", {	Main.process( "1100101010110110" ).should.be( "1100101011110110" ); });
			it( "Parity bit flipped", {	Main.process( "0101011100101011" ).should.be( "0001011100101011" ); });
			it( "Two errors", {	Main.process( "0111010001101111" ).should.be( "TWO ERRORS" ); });
			it( "No Error", {	Main.process( "1001101000000011" ).should.be( "1001101000000011" ); });
			
		});
			
	}

}

