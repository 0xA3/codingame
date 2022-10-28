import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.ArraySort;

/*
Given a DNA sequence s (consisting of bases A, C, G, and T), find all the open reading frames (ORFs) in that sequence. An ORF begins at the base triplet ATG (=start codon), and ends at the first occuring stop codon: TTA, TAG or TGG. Note, that start codon and stop codon need to be in the same reading frame, which means that they have to be separated by 0, 3, 6,... bases. Also note, that ORFs can overlap.
Report the number of found ORFs. For each ORF, report its index (0-based indexing) and the sequence (including start and stop codon) - sort them in descending order of their length and sort ORFs with equal lengths by their ascending index.

Input
CATGTAATGG

Output
1
1 ATGTAATGG
*/

function main() {

	final s = readline();
	final codons = ["TTA", "TAG", "TGG"];
	
	
	final orfs = [];
	var i = 0;
	var count = 0;
	// while( i < s.length - 2 ) {
	while( count++ < 10 && i < s.length - 2 ) {
		var start = s.indexOf( "ATG", i );
		// printErr( 'i $i  start $start' );
		if( start == -1 ) break;
		i = start;
		while( i < s.length - 3 ) {
			i += 3;
			final seq = s.substr( i , 3 );
			// printErr( 'i $i  seq $seq' );
			if( codons.contains( seq )) {
				orfs.push({ begin: start, orf: s.substr( start, i + 3 ) });
				break;
			}
		}
	}
	
	ArraySort.sort( orfs, ( a, b ) -> {
		if( a.orf.length < b.orf.length ) return 1;
		if( a.orf.length > b.orf.length ) return -1;
		if( a.orf < b.orf ) return -1;
		if( a.orf > b.orf ) return 1;

		return 0;
	});
	
	final outputs = orfs.map( x -> '${x.begin} ${x.orf}' );
	print( orfs.length );
	if( orfs.length > 0 ) print( outputs.join("\n") );
}
