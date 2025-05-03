import Std.parseInt;

class BookRank {

	public static inline var TBR = 11;

	public final title:String;
	public final rank:Int;

	public function new( title:String, rank:Int ) {
		this.title = title;
		this.rank = rank;
	}

	public function toString() return '$title $rank';

	public static function parseBookRank( s:String ) {
		final parts = s.split( " " );
		final title = parts.slice( 0, parts.length - 1 ).join( " " );
		final lastPart = parts[parts.length - 1];
		final rank = lastPart == "None" ? TBR : parseInt( lastPart );
		
		return new BookRank( title, rank );
	}

	public static function sortByTitle( a:BookRank, b:BookRank ) {
		if( a.title < b.title ) return -1;
		if( a.title > b.title ) return 1;
		return 0;
	}

	public static function sortByRank( a:BookRank, b:BookRank ) return a.rank - b.rank;
}

