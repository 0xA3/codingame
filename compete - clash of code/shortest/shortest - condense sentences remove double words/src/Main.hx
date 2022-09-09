import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
English is sometimes an annoying language. With this, we often describe nouns, i.e., person, place, or thing, with adjectives, or descriptive words. For instance, The dog is brown. We can also say Joe is smart. We can combine this with a conjunction to get a phrase like, "John is a cool and smart person." However, we often see sentences like, "John is a cool person and smart person." This is redundant, and can be shortened to just "John is a cool and smart person."

Write a program that condenses sentences like this. In other words, given a sentence of the form, "X ... Y Z and W Z", rewrite it to say "X ... Y and W Z".

*/

class Main {
	
	static function main() {
		
		final sentence = readline();
	#if test
		print( process( sentence ));
	}
	// static function process( sentence:String ) {
	// #end
	// 	final parts = sentence.split( "and" );

	// 	final part1Words = parts[0].split(" ");
	// 	final part2Words = parts[1].split(" ");

	// 	for( word in part1Words ) if( part2Words.contains( word )) part2Words.remove( word );
	// #if test return #else print #end( part1Words.join(" ") + "and " + part2Words.join(" ") );
	// }

	static function process( sentence:String ) {
	#end
		final words = sentence.split(" ");
		final words2 = [];

		for( word in words ) if( !words2.contains( word )) words2.push( word );
		#if test return #else print #end( words2.join(" "));
	}
}

