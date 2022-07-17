package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "test -", {
			it( "a", {
				Main.process( 'a' ).should.be( 'a' );
			});
			it( "a-", {
				Main.process( 'a-' ).should.be( '' );
			});
			it( "ab-", {
				Main.process( 'ab-' ).should.be( 'a' );
			});
		});
		describe( "test <", {
			it( "a<b", {
				Main.process( 'a<b' ).should.be( 'ba' );
			});
		});
		describe( "test <>", {
			it( "a<>b", {
				Main.process( 'a<>b' ).should.be( 'ab' );
			});
		});
		describe( "Test process", {
			it( "No mistakes", {
				Main.process( 'echo "Hello World!";' ).should.be( 'echo "Hello World!";' );
			});
			it( "Single mistake", {
				Main.process( "Midnight takes hear<<<<your >>>>t and your soul" ).should.be( "Midnight takes your heart and your soul" );
			});
			it( "Out of bounds", {
				Main.process( "<<SELECT * FROM users WHERE age >= 18>>;" ).should.be( "SELECT * FROM users WHERE age = 18;" );
			});
			it( "Backspace 1", {
				Main.process( "print $_=~/[0-9a-z]/i;" ).should.be( "print $_=~/[9z]/i;" );
			});
			it( "Backspace 2", {
				Main.process( "x--?i--:y-D" ).should.be( ":D" );
			});
			it( "007", {
				Main.process( '.<on<<"B>>d> me<<Ja>>>ss- on<<B>>>d." 7<00<<- ' ).should.be( '"Bond. James Bond." 007' );
			});
		});
	}
}
