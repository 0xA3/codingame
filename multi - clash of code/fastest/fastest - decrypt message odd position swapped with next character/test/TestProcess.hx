package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Encrypt", {
			it( "Message", { Main.encrypt( "This is a message" ).should.be( "ehTsii  s aemssga" ); });
			it( "Second message", { Main.encrypt( "This is second message" ).should.be( "hTsii  sesocdnm seaseg" ); });
			it( "a", { Main.encrypt( "a" ).should.be( "a" ); });
			it( "aa___", { Main.encrypt( " a  a" ).should.be( "aa   " ); });
			it( "Harry Potter", { Main.encrypt( "HARRY POTTER AND THE GOBLET OF FIRE" ).should.be( "EAHRR YOPTTREA DNT EHG BOEL TFOF RI" ); });
			it( "abcde", { Main.encrypt( "abcde" ).should.be( "ebadc" ); });
			it( "abcd", { Main.encrypt( "abcd" ).should.be( "badc" ); });
		});

		describe( "Test Process", {
			it( "Message", { Main.process( "ehTsii  s aemssga" ).should.be( "This is a message" ); });
			it( "Second message", { Main.process( "hTsii  sesocdnm seaseg" ).should.be( "This is second message" ); });
			it( "a", { Main.process( "a" ).should.be( "a" ); });
			it( "aa___", { Main.process( "aa   " ).should.be( " a  a" ); });
			it( "Harry Potter", { Main.process( "EAHRR YOPTTREA DNT EHG BOEL TFOF RI" ).should.be( "HARRY POTTER AND THE GOBLET OF FIRE" ); });
			it( "abcde", { Main.process( "ebadc" ).should.be( "abcde" ); });
			it( "abcd", { Main.process( "badc" ).should.be( "abcd" ); });
		});
	}
}

