package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Hello world", {
				final ip = helloWorld;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "HELLO_WORLD" ); });
			it( "Baking your code", {
				final ip = bakingYourCode;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "THE_PIE_IS_IN_THE_OVEN" ); });
			it( "Ominous", {
				final ip = ominous;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "1_YOU_CAN_RUN_BUT_2_YOU_CANT_HIDE" ); });
			it( "Common knowledge", {
				final ip = commonKnowledge;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "THE_WAY_BACK_IS_A_LONG_ROAD_IF_YOU_LOSE_YOUR_MAP-UNKNOWN" ); });
			it( "First Multiplier", {
				final ip = firstMultiplier;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "WHATS_UP" ); });
			it( "So Cryptic", {
				final ip = soCryptic;
				Main.process( ip.alphabet, ip.message, ip.word ).should.be( "YOU_CANT_ALWAYS_GET_WHAT_YOU_WANT" ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { alphabet: lines[0].split( "" ), message: lines[1], word: lines[2] };
	}
	
	final helloWorld = parseInput(
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ_
		IFMMPAXPSME
		WORLD"
	);

	final bakingYourCode = parseInput(
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ_
		APMHXQMHQ_HQVHAPMHWCMV
		PIE"
	);

	final ominous = parseInput(
		"ABCDE1FGH2IJK5LMN7OPQR8STU9VWXYZ_
		AVU5QVYWJVNQJVXQPVEVU5QVYWJPVD1Z_
		HIDE"
	);

	final commonKnowledge = parseInput(
		"A1B2C3D4E5F6G7H8I9J0K-L+M=NOP;Q:R<S>T?U,V.W/XY|Z_
		/-8DA42D546OD+.D4D;S<0D,S47D+9D2SYD;S.8D2SY,D:4>PY<O<SA<
		UNKNOWN"
	);

	final firstMultiplier = parseInput(
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ_
		NQVTMO_S
		WHAT"
	);

	final soCryptic = parseInput(
		"A1B2C3D4E5F6G7H8I9J0K-L+M=NOP;Q:R<S>T?U,V.W/XY|Z_
		_A74CNQM4N2VN_>45:M4VZNM4_A74VNQM
		ALWAYS"
	);


}

