package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Exact Match - Easy", {
				final ip = exactMatchEasy;
				Main.process( ip.delta, ip.gene, ip.chrs ).should.be( "0 0 0" ); });
			it( "No Match", {
				final ip = noMatch;
				Main.process( ip.delta, ip.gene, ip.chrs ).should.be( "NONE" ); });
			it( "Many Lines, inexact match", {
				final ip = manyLinesInexactMatch;
				Main.process( ip.delta, ip.gene, ip.chrs ).should.be( "10 86 2" ); });
			it( "Overflow", {
				final ip = overflow;
				Main.process( ip.delta, ip.gene, ip.chrs ).should.be( "1 91 5" ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final delta = parseInt( lines[0] );
		final gene = lines[1];
		final n = parseInt( lines[2] );
		var chrs = [for( i in 0...n ) lines[i + 3]];
				
		return { delta: delta, gene: gene, chrs: chrs };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final exactMatchEasy = parseInput(
	"0
	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	1
	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACCTCGTGGAGGAGGGTGTCTCCTGCTTGCTGAACATGACTAAAGAATTATTAAATTTTACGTAGGAAATCTTATGTCATAGGGGTG" );

	final noMatch = parseInput(
	"2
	ATCTGTATACTCTAATTCATGTTTGGTTGCAAATGTTATCTA
	1
	TTCGGTGCAGGTAGATCATAGAGTATCAATTGGTCTGAGATGAGGAGAAACGCCTCAGCTACTGACCTAACGTAACATACCATTGTGAGTTCCCTGGTTCTTTTTAGGGTCATCCCTTACTCTTTAAA" );

	final manyLinesInexactMatch = parseInput(
	"3
	CCGATATTGGTAAGCTCATATTTCCGGCGGGGACCGTGCCAG
	11
	TCTTCCCGTTCGAAGCGCGCGACCCGGGTTCGAAATCTAGCATGTCCTGTTTCAATTCTTCTCCGCCAATGCACCCTGAGAATGCGATCTGTCCTATCACTCGATGCACATGCGCTCCTTATGTGACC
	TCCAACCGATTGCCAGATCAAAGACGTGGTCCAAATAGCCGATATTGGTAAGCTCATATTTCCGTGCCGTACCGCTTCAGGATAGACAAATATCTTTTAACCGGATAAGAGCATAGGGCCGCCGCCGT
	TTTGGTTGGGTGAGATTGATGTCGGGGTTCCTCACTACTTTTCTGGTTACGCACCAAAATAGAGTACCGCTTCGCCCAACATGAGCACAACCTACTGGCACACGGGACAAAAGACCTAGTTCGATCCC
	TAATCGTAACACGCTCTAGGCAGACACGCCTTGTAGTACGCACTTCCTGCGGAACATGGATACTGATATATAAGTCGCACCTCCGTATTTTTACCAATTGGACTGCAGCAAGTACGGTTTACAAAGCA
	TGGGATATATAGTCTATGCCCCGACCGACCGGCAGTGGGCTCTGATTTTCTAGCACAATGCGTAGTGGTCTAACGCTACCCACACAGTTCTGGTTCAGATCATAATGAGAACTCAATAGTATGCATCA
	CTGTATGTTCAAATTTCGGCCCGGCCGGGGAGGCACGGCTGTGGTACCATGGAGAACACCTTAGCCCGACAGACATGTGGGGCTTGGTCAACTGCGCAAGACCCGGAGCACCCAGCTGTGGTCTATGC
	GGGTCTTGTAAATGAGGTCGTTAATGAAAATACTATAGTCTTAGCGAATGGCTTAACTATGAAGGGTACATGAGAACTCTTTTCCAGACCATCCATGAAAACCATGTGTGTGTGGACAGGTAACCAGG
	CGATTCGTGAAGTTCACTACCTGCTATGGTTATCAACACAGAACGGGGGATCTCAGTTCGAACGAAAAGTCGTACAGATGTGGCTCTAATTAAGAATGACGACATAAAGAAGAAGCTGGGAATAGCAT
	GTAACAAACGATGAGGAGGCCGTGCAAGTATGGATTATAACTCTCTGTGATCGCTTGCATTGACGGAGTGTCGTTGGAATCACGGAACGACGTATTCTATGTCATCGACGGGTGCCACGTAAACCTAG
	GAATACATCGCCAAGTATTCACGTCGATAACTTATTGTCCGTTCAGGTCTAGCCGGCCCTAACCATGGCGTTTCCGTATGACGATACTATGGTTACGGGAAGCTCGTACCGGTGGGAGAGGTCTAACA
	AGCATCCACTAATCCTCACAAGGGATTTCAAATGACGGAGTAGAGGGAGTCATGCTCGCATGATCCCTGAGCCCCATACGGATCGACCGATATTGGTAAGCTCATATTTAAGGCGGGGACCGTGCCAG" );

	final overflow = parseInput(
	"5
	ATACTACTAGGCCCTTTCATACGGATACCTTCTGCTTAATCG
	3
	TCGAGCACTGTAGCAAGAACTCTTTAATAGCGATACCAGGATCCCCTGCGTATCTAGACACAGTACGTGAAGCGTCGGCTTGTATCCCTGCTCCCTGCCACAAGAACTAACAATTGCCGGAGGTGTTC
	ATACGTCCCCCGGTGTCAATTATTGTGTATCGGCCGGTAGCCGAAAAAAAGAGTTAGTTTTATGGCCTAGTATGGACAAAGGTAATTAGTGATACTACTAGGCCCTTTCATACGGATACCTTCTGCTT
	ATATTTGCGGTTACAGTACCCCCACGGCGCGTGGTTCTGGGTTATCACTCTTTTTTCCTACGCTAGCCGCGTCGGAATTAGTTAGCCGGATGACTGGTCTGTATCCGCTGGTGCATTATAGTCCCTGG" );
}
