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
			
			it( "Test 1", {
				final p = test1;
				Main.process( p.input, p.states, p.transitions, p.startState, p.endStates, p.words ).should.be( test1Result );
			});
			
			it( "Test 2", {
				final p = test2;
				Main.process( p.input, p.states, p.transitions, p.startState, p.endStates, p.words ).should.be( test2Result );
			});

			it( "Test 3", {
				final p = test3;
				Main.process( p.input, p.states, p.transitions, p.startState, p.endStates, p.words ).should.be( test3Result );
			});

			it( "Test 4", {
				final p = test4;
				Main.process( p.input, p.states, p.transitions, p.startState, p.endStates, p.words ).should.be( test4Result );
			});

		});
	}

	static function parseInput( s:String ) {
		final lines = s.split( "\n" );
		final input = lines[0].trim();
		final states = lines[1].trim();
		final numberOfTransitions = parseInt( lines[2] );
		final transitions = [for( i in 0...numberOfTransitions ) lines[3 + i].trim()];
		final startState = lines[3 + numberOfTransitions].trim();
		final endStates = lines[3 + numberOfTransitions + 1].split(" ").map( id -> id.trim());
		final numberOfWords = parseInt( lines[3 + numberOfTransitions + 2] );
		final words = [for( i in 0...numberOfWords ) lines[3 + numberOfTransitions + 3 + i].trim()];

		return { input: input, states: states, transitions: transitions, startState: startState, endStates: endStates, words: words };

	}

	static function parseResult( s:String ) {
		return s.split( "\n" ).map( s -> s.trim()).join( "\n" );
	}

	final test1 = parseInput(
	"a b c
	A B
	6
	A a B
	A b B
	A c B
	B a A
	B b A
	B c A
	A
	B
	10
	a
	ab
	abc
	abcd
	abcde
	aabbcc
	aabbcca
	abcabcabc
	z
	abcabcabo" );

	final test1Result = parseResult(
	"true
	false
	true
	false
	false
	false
	true
	true
	false
	false" );

	final test2 = parseInput(
	"a b c d
	A B C D
	16
	A a A
	A b B
	A c A
	A d A
	B a A
	B b B
	B c C
	B d A
	C a A
	C b B
	C c A
	C d D
	D a A
	D b B
	D c A
	D d A
	A
	D
	5
	bcd
	abacdb
	aaabbccadbcd
	aaabcdbdebcd
	bcdbcdbcdbcd" );

	final test2Result = parseResult(
	"true
	false
	true
	false
	true" );

	final test3 = parseInput(
	"a b c d
	A B C
	6
	A a B
	B c C
	C a C
	C b C
	C c C
	C d C
	A
	C
	7
	ac
	ab
	acabcd
	acabcde
	a
	acaaacca
	cafds" );

	final test3Result = parseResult(
	"true
	false
	true
	false
	false
	true
	false" );

	final test4 = parseInput(
	"a b c
	A B C
	5
	A a A
	A b B
	B a B
	B b A
	B c C
	A
	A B
	6
	bc
	bbabc
	aaaabababaac
	aaaaabaaaabbaa
	abbabacc
	abababababbadabbba" );

	final test4Result = parseResult(
	"false
	false
	false
	true
	false
	false" );

}

