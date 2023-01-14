import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
The nucleotides inside a DNA sequence can be represented by a string composed by A, C, G and T. A sample string representing a DNA sequence is "ATGCTTCAGAAAAGGTCAGCG".

Your task is to count how many times the symbols A, C, G and T appear in the string s.

*/

function main() {

	final line = readline();
	final as = line.count("A");
	final cs = line.count("C");
	final gs = line.count("G");
	final ts = line.count("T");

	print( '$as $cs $gs $ts' );
}
