package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "2 input signals, 3 gates", {
				final ip = twoInputSignalsThreeGates;
				Main.process( ip.inputs, ip.operations ).should.be( twoInputSignalsThreeGatesResult );
			});
			it( "Inverter (NAND)", {
				final ip = inverterNAND;
				Main.process( ip.inputs, ip.operations ).should.be( inverterNANDResult );
			});
			it( "AND", {
				final ip = AND;
				Main.process( ip.inputs, ip.operations ).should.be( ANDResult );
			});
			it( "OR", {
				final ip = OR;
				Main.process( ip.inputs, ip.operations ).should.be( ORResult );
			});
			it( "XOR", {
				final ip = XOR;
				Main.process( ip.inputs, ip.operations ).should.be( XORResult );
			});
			it( "Buffer (OR)", {
				final ip = bufferOR;
				Main.process( ip.inputs, ip.operations ).should.be( bufferORResult );
			});
			it( "NAND", {
				final ip = NAND;
				Main.process( ip.inputs, ip.operations ).should.be( NANDResult );
			});
			it( "NOR", {
				final ip = NOR;
				Main.process( ip.inputs, ip.operations ).should.be( NORResult );
			});
			it( "NXOR", {
				final ip = NXOR;
				Main.process( ip.inputs, ip.operations ).should.be( NXORResult );
			});
			it( "allGates", {
				final ip = allGates;
				Main.process( ip.inputs, ip.operations ).should.be( allGatesResult );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final m = parseInt( lines[1] );
		final inputs:Map<String, Array<Int>> = [for( i in 0...n ) {
			var inputs = lines[i + 2].split(' ');
			inputs[0] => inputs[1].split( '' ).map( s -> s == "_" ? 0 : 1 );
		}];

		final operations:Array<Operation> = [for( i in 0...m ) {
			var inputs = lines[i + 2 + n].split(' ');
			{ outputName: inputs[0], type: inputs[1], inputName1: inputs[2], inputName2: inputs[3] }
		}];
		
		return { inputs: inputs, operations: operations }
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final twoInputSignalsThreeGates = parseInput(
	"2
	3
	A __---___---___---___---___
	B ____---___---___---___---_
	C AND A B
	D OR A B
	E XOR A B" );

	static final twoInputSignalsThreeGatesResult = parseResult(
	"C ____-_____-_____-_____-___
	D __-----_-----_-----_-----_
	E __--_--_--_--_--_--_--_--_" );

	static final inverterNAND = parseInput(
	"1
	1
	A __---___---___---___---___
	B NAND A A" );

	static final inverterNANDResult = parseResult(
	"B --___---___---___---___---" );

	static final AND = parseInput(
	"3
	3
	CLK _-_-_-_-_-_-_-_-_-_-_-_-_-
	IN1 ___---___---___---___---__
	IN2 --__--__--__--__--__--__--
	OUT1 AND CLK IN1
	OUT2 AND CLK IN2
	OUT3 AND IN1 IN2" );

	static final ANDResult = parseResult(
	"OUT1 ___-_-___-_-___-_-___-_-__
	OUT2 _-___-___-___-___-___-___-
	OUT3 ____--___-______--___-____" );

	static final OR = parseInput(
	"3
	3
	CLK _-_-_-_-_-_-_-_-_-_-_-_-_-
	IN1 ----____----____----____--
	IN2 --__--__--__--__--__--__--
	OUT1 OR CLK IN1
	OUT2 OR CLK IN2
	OUT3 OR IN1 IN2" );

	static final ORResult = parseResult(
	"OUT1 ----_-_-----_-_-----_-_---
	OUT2 --_---_---_---_---_---_---
	OUT3 ------__------__------__--" );

	static final XOR = parseInput(
	"3
	3
	CLK _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	IN1 __--__--__--__--__--__--__--__--_
	IN2 ___---___---___---___---___---___
	OUT1 XOR IN1 CLK
	OUT2 XOR IN2 CLK
	OUT3 XOR IN2 IN1" );

	static final XORResult = parseResult(
	"OUT1 _--__--__--__--__--__--__--__--__
	OUT2 _-__-__-__-__-__-__-__-__-__-__-_
	OUT3 __-_----_-____-_----_-____-_----_" );

	static final bufferOR = parseInput(
	"1
	1
	IN0 -_--__---___----____-_--__---___
	OUT OR IN0 IN0" );

	static final bufferORResult = parseResult(
	"OUT -_--__---___----____-_--__---___" );

	static final NAND = parseInput(
	"3
	3
	CLK _-_-_-_-_-_-_-_-_-_-_-_-_-
	IN1 ___---___---___---___---__
	IN2 --__--__--__--__--__--__--
	OUT1 NAND CLK IN1
	OUT2 NAND CLK IN2
	OUT3 NAND IN1 IN2" );

	static final NANDResult = parseResult(
	"OUT1 ---_-_---_-_---_-_---_-_--
	OUT2 -_---_---_---_---_---_---_
	OUT3 ----__---_------__---_----" );

	static final NOR = parseInput(
	"3
	2
	IN1 --__--__--__--__--__--__--__--__--__
	IN2 ____----____----____----____----____
	IN3 --------________--------________----
	OUT1 NOR IN2 IN1
	OUT2 NOR IN2 IN3" );

	static final NORResult = parseResult(
	"OUT1 __--______--______--______--______--
	OUT2 ________----____________----________" );

	static final NXOR = parseInput(
	"4
	3
	A -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
	B --__--__--__--____----____----______------
	C -_-__--__--__---___---___---___----____---
	D -----_____-----_____-----_____-----_____--
	X NXOR A B
	Y NXOR B C
	Z NXOR C D" );

	static final NXORResult = parseResult(
	"X -__--__--__--__-_--_-__-_--_-__-_-_--_-_-_
	Y -__-_-_-_-_-_-__--_------_--__-____-___---
	Z -_-____--_-__--_---_--______--_--------_--" );

	static final allGates = parseInput(
	"4
	16
	ZORGLUB ----____----____----____----____----____--
	MEGAMAN --____----____----____----____----____----
	ZOLTRON ---___---___------______------______-_-_-_
	PEW_PEW -_-_-_-_------_____----____---___--__--__-
	OUTPUT1 AND ZORGLUB MEGAMAN
	OUTPUT2 OR ZORGLUB ZOLTRON
	OUTPUT3 XOR ZORGLUB PEW_PEW
	OUTPUT4 AND ZORGLUB ZORGLUB
	ROGUE_1 OR MEGAMAN MEGAMAN
	ROGUE_2 NAND MEGAMAN MEGAMAN
	ROGUE_3 NOR PEW_PEW PEW_PEW
	ROGUE_4 NXOR PEW_PEW MEGAMAN
	SQUAD_1 NAND PEW_PEW MEGAMAN
	SQUAD_2 OR ZOLTRON PEW_PEW
	SQUAD_3 NOR ZOLTRON PEW_PEW
	SQUAD_4 AND ZOLTRON PEW_PEW
	MIKADO1 AND MEGAMAN PEW_PEW
	MIKADO2 OR MEGAMAN PEW_PEW
	MIKADO3 XOR MEGAMAN MEGAMAN
	MIKADO4 NXOR ZOLTRON ZOLTRON" );

	static final allGatesResult = parseResult(
	"OUTPUT1 --______--______--______--______--______--
	OUTPUT2 ----__--------------____------__-----_-_--
	OUTPUT3 _-_--_-_____--__---_---_---_--__-__-_--_-_
	OUTPUT4 ----____----____----____----____----____--
	ROGUE_1 --____----____----____----____----____----
	ROGUE_2 __----____----____----____----____----____
	ROGUE_3 _-_-_-_-______-----____----___---__--__--_
	ROGUE_4 -__-_--_--________-___-___-______-_--_-__-
	SQUAD_1 _-----_-__------------_----------_----_--_
	SQUAD_2 ---_-_------------_----_------___--_---_--
	SQUAD_3 ___-_-____________-____-______---__-___-__
	SQUAD_4 -_-___-_-___--_____________---________-___
	MIKADO1 -_____-_--____________-__________-____-__-
	MIKADO2 ---_-_------------_-------_--------__-----
	MIKADO3 __________________________________________
	MIKADO4 ------------------------------------------" );
}

