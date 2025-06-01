package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "OS INFO", Main.process( osInfo ).should.be( osInfoResult ));
			it( "ABCD", Main.process( abcd ).should.be( abcdResult ));
			it( "SET / UPDATE", Main.process( setUpdate ).should.be( setUpdateResult ));
			it( "codin-game", Main.process( codinGame ).should.be( codinGameResult ));
			it( "NULL", Main.process( _null ).should.be( _nullResult ));
			it( "All", Main.process( all ).should.be( allResult ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final n = parseInt( readline() );
		final instructions = [for( _ in 0...n ) readline()];
					
		return instructions;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final osInfo = parseInput(
		"3
		SET os-name=windows
		SET os-arch=x64
		GET os-name os-arch"
	);

	final osInfoResult = parseResult(
		"windows x64"
	);

	final abcd = parseInput(
		"3
		SET A=A B=B C=C D=D
		KEYS
		GET A B C D"
	);

	final abcdResult = parseResult(
		"A B C D
		A B C D"
	);

	final setUpdate = parseInput(
		"4
		SET password=root password=admin
		SET username=root username=admin
		KEYS
		GET username password"
	);

	final setUpdateResult = parseResult(
		"password username
		admin admin"
	);

	final codinGame = parseInput(
		"12
		KEYS
		SET c=c
		SET o=o
		SET d=d
		SET i=i
		SET n=n
		SET -=-
		SET g=g
		SET a=a
		SET m=m
		SET e=e
		GET c o d i n - g a m e"
	);

	final codinGameResult = parseResult(
		"EMPTY
		c o d i n - g a m e"
	);

	final _null = parseInput(
		"3
		KEYS
		GET A B C
		KEYS"
	);

	final _nullResult = parseResult(
		"EMPTY
		null null null
		EMPTY"
	);

	final all = parseInput(
		"17
		KEYS
		SET x=10 y=20 z=30
		SET y=200 w=40
		GET q x y w z
		EXISTS w y q x z
		KEYS
		SET q=q r=r s=s r=R s=S
		GET R q S
		EXISTS r s t
		SET t=tree u=universe v=tree w=planet
		GET u t v w m
		EXISTS m u x
		KEYS
		SET x=XX y=YY z=ZZ x=XXX
		GET y x z
		EXISTS y x z
		KEYS"
	);

	final allResult = parseResult(
		"EMPTY
		null 10 200 40 30
		true true false true true
		x y z w
		null q null
		true true false
		universe tree tree planet null
		false true true
		x y z w q r s t u v
		YY XXX ZZ
		true true true
		x y z w q r s t u v"
	);
}