import haxe.ds.Vector;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final l = parseInt(readline());
		final n = parseInt(readline());
		
		// printErr( 'length $l number $n' );
		
		final range:Array<Section> = [{ start: 0, end: l, isPainted: false }];

		final paintedSections:Array<Section> = [];
		for( i in 0...n ) {
			var inputs = readline().split(' ');
			final st = parseInt( inputs[0] );
			final ed = parseInt( inputs[1] );
			// printErr( 'start $st end $ed' );
			paintedSections.push({ start: st, end: ed, isPainted: true });
		}
		paintedSections.sort( sortSections );

		final inputSections = range.concat( paintedSections );

		// final cuts = inputSections.flatMap( section -> [section.start, section.end]);
		final cuts:Array<Int> = [];
		for( inputSection in inputSections ) {
			if( !cuts.contains( inputSection.start )) cuts.push( inputSection.start );
			if( !cuts.contains( inputSection.end )) cuts.push( inputSection.end );
		}
		cuts.sort(( a, b ) -> a - b );
		
		// printErr( 'cuts $cuts' );
		// printErr( paintedSections.map( s -> sString( s ) ).join( "\n" ));

		final sections:Array<Section> = [];
		for( i in 0...cuts.length - 1 ) {
			final start = cuts[i];
			final end = cuts[i + 1];
			var isPainted = false;
			// printErr( 'compare $start $end' );
			for( s in paintedSections ) {
				// printErr( 'with ${s.start} ${s.end} ${s.start <= start && s.end >= end}' );
				if( s.start <= start && s.end >= end ) {
					isPainted = true;
					break;
				}
			}
			sections.push({ start: start, end: end, isPainted: isPainted });
		}

		final mergedSections:Array<Section> = [];
		var s1 = sections[0];
		for( i in 1...sections.length ) {
			final s2 = sections[i];
			// printErr( 'compare ${sString( s1 )} ${sString( s2 )}' );
			if( s1.isPainted == s2.isPainted ) {
				s1 = { start: s1.start, end: s2.end, isPainted: s1.isPainted };
				// printErr( 's1 ${sString( s1 )}' );
			} else {
				mergedSections.push( s1 );
				// printErr( 'push ${s1.start}:${s1.end} ${s1.isPainted}' );
				s1 = s2;
				
			}
			if( i == sections.length - 1 ) mergedSections.push( s1 );
		}

		// printErr( sections.map( s -> sString( s ) ).join( "\n" ));
		final unpaintedSections = mergedSections.filter( s -> !s.isPainted );
		print( unpaintedSections.length == 0 ? "All painted" : unpaintedSections.map( s -> '${s.start} ${s.end}' ).join( "\n" ));
	}

	static function startsAt( sections:Array<Section>, start:Int ) {
		for( section in sections ) if( section.start == start ) return true;
		return false;

	}

	static function sortSections( a:Section, b:Section ) {
		return a.start - b.start;
	}

	static function sString( s:Section ) {
		return '[${s.start}:${s.end}] ${s.isPainted}';
	}

}

typedef Section = {
	final start:Int;
	final end:Int;
	final isPainted:Bool;
}