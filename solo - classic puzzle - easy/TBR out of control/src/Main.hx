import BookRank.TBR;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;


function main() {

	final b = parseInt( readline() );
	final newBooks = [for( i in 0...b ) readline()];

	final n = parseInt( readline() );
	final booksOnShelf = [for( i in 0...n ) readline()];

	final result = process( newBooks, booksOnShelf );
	print( result );
}

function process( newBooks:Array<String>, booksOnShelf:Array<String> ):String {
	final shelfSize = booksOnShelf.length;
	var bookRanks:Array<BookRank> = [for( s in booksOnShelf ) BookRank.parseBookRank( s )];
	final favoriteBooksRank = getFavoriteBooksRank( bookRanks );

	for( newBook in newBooks ) bookRanks.push( new BookRank( newBook, TBR ));

	while( bookRanks.length > shelfSize ) {
		bookRanks = removeDuplicates( bookRanks );
		bookRanks.sort( BookRank.sortByRank );
		final lowestRank = bookRanks[0];
		if( lowestRank.rank == favoriteBooksRank ) return "Your TBR is out of control Clara!";
		bookRanks = bookRanks.filter( br -> br.rank > lowestRank.rank );
	}

	bookRanks.sort( BookRank.sortByTitle );

	return bookRanks.map( br -> br.title ).join( "\n" );
}

function getFavoriteBooksRank( bookRanks:Array<BookRank> ) {
	var favoriteBooksRank = -1;
	for( bookRank in bookRanks ) {
		if( bookRank.rank < TBR && bookRank.rank > favoriteBooksRank ) {
			favoriteBooksRank = bookRank.rank;
		}
	}

	return favoriteBooksRank;
}

function removeDuplicates( bookRanks:Array<BookRank> ) {
	final set = [for( br in bookRanks ) br.title => br];
	return Lambda.array( set );
}
