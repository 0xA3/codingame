package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", { Main.process( "λx.λy.xyz" ).should.be( test1Result ); });
			it( "Test2", { Main.process( "λx.x" ).should.be( test2Result ); });
			it( "Test3", { Main.process( "λy.yzxw" ).should.be( test3Result ); });
			it( "Test4", { Main.process( "λw.λx.λy.λz.z" ).should.be( test4Result ); });
			it( "Test5", { Main.process( "λv.λw.λx.λy.λz.vwyu" ).should.be( test5Result ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final test1Result = parseResult(
	"x y
	z
	NONE" );

	static final test2Result = parseResult(
	"x
	NONE
	NONE" );

	static final test3Result = parseResult(
	"y
	z x w
	NONE" );

	static final test4Result = parseResult(
	"z
	NONE
	w x y" );

	static final test5Result = parseResult(
	"v w y
	u
	x z" );
}
