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
			
			it( "Simple case", {
				final ip = simpleCase;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( simpleCaseResult );
			});
			
			it( "Long TBR", {
				final ip = longTBR;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( longTBRResult );
			});
			
			it( "Small bookshelf", {
				final ip = smallBookshelf;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( smallBookshelfResult );
			});
			
			it( "Duplicate", {
				final ip = duplicate;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( duplicateResult );
			});
			
			it( "New space", {
				final ip = newSpace;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( newSpaceResult );
			});
			
			it( "Favorite books", {
				final ip = favoriteBooks;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( favoriteBooksResult );
			});
			
			it( "Duplicate is favorite", {
				final ip = duplicateIsFavorite;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( duplicateIsFavoriteResult );
			});
			
			it( "Duplicate again...", {
				final ip = duplicateAgain;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( duplicateAgainResult );
			});
			
			it( "Test 9", {
				final ip = test_9;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( test_9Result );
			});
			
			it( "Test 10", {
				final ip = test_10;
				Main.process( ip.newBooks, ip.booksOnShelf ).should.be( test_10Result );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final b = parseInt( readline() );
		final newBooks = [for( i in 0...b ) readline()];
	
		final n = parseInt( readline() );
		final booksOnShelf = [for( i in 0...n ) readline()];
	
		return { newBooks: newBooks, booksOnShelf: booksOnShelf }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleCase = parseInput(
		"2
		A court of thorns and roses
		Notre-Dame de Paris
		5
		Powerless 9
		The scarlet letter 8
		Babbel None
		Yellowface 4
		Divine Rivals 5"
	);

	final simpleCaseResult = parseResult(
		"A court of thorns and roses
		Babbel
		Notre-Dame de Paris
		Powerless
		The scarlet letter"
	);

	final longTBR = parseInput(
		"3
		A court of thorns and roses
		Notre-Dame de Paris
		1984
		11
		The scarlet letter 8
		Babbel None
		Powerless 9
		Holly None
		Forth Wing None
		Yellowface None
		Divine Rivals None
		Hunger games 8
		The villa None
		Ninth House None
		Moby-dick None"
	);

	final longTBRResult = parseResult(
		"Your TBR is out of control Clara!"
	);

	final smallBookshelf = parseInput(
		"1
		Throne of glass
		1
		Shadows and Bone 8"
	);

	final smallBookshelfResult = parseResult(
		"Your TBR is out of control Clara!"
	);

	final duplicate = parseInput(
		"4
		A court of thorns and roses
		Moby-dick
		Notre-Dame de Paris
		1984
		10
		Powerless 9
		The scarlet letter 8
		Babbel None
		Holly 6
		Forth Wing None
		Moby-dick None
		Divine Rivals None
		Hunger games None
		The villa None
		Ninth House 7"
	);

	final duplicateResult = parseResult(
		"1984
		A court of thorns and roses
		Babbel
		Divine Rivals
		Forth Wing
		Hunger games
		Moby-dick
		Notre-Dame de Paris
		Powerless
		The villa"
	);

	final newSpace = parseInput(
		"4
		A court of thorns and roses
		Heartless
		Notre-Dame de Paris
		1984
		10
		Powerless 9
		The scarlet letter 8
		Babbel 6
		Holly 6
		Forth Wing 7
		Moby-dick 3
		Divine Rivals 6
		Hunger games None
		The villa 2
		Ninth House 7"
	);

	final newSpaceResult = parseResult(
		"1984
		A court of thorns and roses
		Forth Wing
		Heartless
		Hunger games
		Ninth House
		Notre-Dame de Paris
		Powerless
		The scarlet letter"
	);

	final favoriteBooks = parseInput(
		"2
		Heartless
		Notre-Dame de Paris
		4
		Powerless 9
		The scarlet letter 8
		Forth Wing 9
		Hunger games None"
	);

	final favoriteBooksResult = parseResult(
		"Your TBR is out of control Clara!"
	);

	final duplicateIsFavorite = parseInput(
		"4
		A court of thorns and roses
		Powerless
		Notre-Dame de Paris
		1984
		10
		Powerless 9
		The scarlet letter 8
		Babbel None
		Holly 6
		Forth Wing None
		Moby-dick None
		Divine Rivals None
		Hunger games None
		The villa None
		Ninth House 7"
	);

	final duplicateIsFavoriteResult = parseResult(
		"1984
		A court of thorns and roses
		Babbel
		Divine Rivals
		Forth Wing
		Hunger games
		Moby-dick
		Notre-Dame de Paris
		Powerless
		The villa"
	);

	final duplicateAgain = parseInput(
		"4
		A court of thorns and roses
		Moby-dick
		Notre-Dame de Paris
		1984
		14
		Powerless 9
		The scarlet letter 8
		Babbel None
		A court of thorns and roses 7
		Holly 6
		Forth Wing 7
		Yellowface 4
		Divine Rivals 5
		Hunger games 8
		The villa None
		Moby-dick 3
		Ninth House 6
		The martian 8
		Captive 1"
	);

	final duplicateAgainResult = parseResult(
		"1984
		A court of thorns and roses
		Babbel
		Divine Rivals
		Forth Wing
		Holly
		Hunger games
		Moby-dick
		Ninth House
		Notre-Dame de Paris
		Powerless
		The martian
		The scarlet letter
		The villa"
	);

	final test_9 = parseInput(
		"4
		A court of thorns and roses
		Moby-dick
		Notre-Dame de Paris
		1984
		10
		Powerless 9
		The scarlet letter 8
		Babbel None
		Holly 6
		Forth Wing 7
		Yellowface 4
		Divine Rivals 5
		Hunger games 8
		The villa None
		Ninth House 6"
	);

	final test_9Result = parseResult(
		"1984
		A court of thorns and roses
		Babbel
		Forth Wing
		Hunger games
		Moby-dick
		Notre-Dame de Paris
		Powerless
		The scarlet letter
		The villa"
	);

	final test_10 = parseInput(
		"4
		A court of thorns and roses
		Moby-dick
		Notre-Dame de Paris
		1984
		11
		Powerless 9
		The scarlet letter 8
		Babbel None
		Holly 6
		A court of thorns and roses 9
		Forth Wing 7
		Yellowface 4
		Divine Rivals 5
		Hunger games 8
		The villa None
		Ninth House 6"
	);

	final test_10Result = parseResult(
		"1984
		A court of thorns and roses
		Babbel
		Forth Wing
		Hunger games
		Moby-dick
		Notre-Dame de Paris
		Powerless
		The scarlet letter
		The villa"
	);
}
