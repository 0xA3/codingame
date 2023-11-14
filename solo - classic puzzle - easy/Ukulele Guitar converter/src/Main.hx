import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef StringFret = {
	final string:Int;
	final fret:Int;
}

final GUITAR_FRETS = 21;
final UKULELE_FRETS = 15;

final guitarTuning = ["E4", "B3", "G3", "D3", "A2", "E2"];
final ukuleleTuning = ["A4", "E4", "C4", "G4"];

final notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

final guitarNotes = [for( string in 0...guitarTuning.length ) [for( fret in 0...GUITAR_FRETS + 1 ) getNote( guitarTuning, string, fret )]];
final ukuleleNotes = [for( string in 0...ukuleleTuning.length ) [for( fret in 0...UKULELE_FRETS + 1 ) getNote( ukuleleTuning, string, fret )]];

function main() {
	final mode = readline();
	final n = parseInt( readline());
	final stringFrets = [for( i in 0...n ) {
		final inputs = readline().split(" ");
		{ string: parseInt( inputs[0] ), fret: parseInt( inputs[1] )}
	}];
	
	final result = process( mode, stringFrets );
	print( result );
}

function process( mode:String, stringFrets:Array<StringFret> ) {
	switch mode {
		case "guitar": return guitarToUkulele( stringFrets );
		case "ukulele": return ukuleleToGuitar( stringFrets );
		default: throw 'Error: unknown mode $mode';
	}
}

function guitarToUkulele( stringFrets:Array<StringFret> ) {
	final notes = stringFrets.map( sf -> guitarNotes[sf.string][sf.fret] );
	final ukulelePositions = notes.map( note -> getPosition( note, ukuleleNotes ));
	return ukulelePositions.join( "\n" );
}

function ukuleleToGuitar( stringFrets:Array<StringFret> ) {
	final notes = stringFrets.map( sf -> ukuleleNotes[sf.string][sf.fret] );
	final guitarPositions = notes.map( note -> getPosition( note, guitarNotes ));
	return guitarPositions.join( "\n" );
}

function getNote( tuning:Array<String>, string:Int, fret:Int ) {
	final tune = tuning[string];
	final noteId = notes.indexOf( tune.charAt( 0 ));
	final octave = parseInt( tune.charAt( 1 ));

	final noteResult = notes[( noteId + fret ) % notes.length];
	final octaveResult = octave + int(( noteId + fret ) / notes.length );
	
	final noteOctave:NoteOctave = { note: noteResult, octave: octaveResult }

	return noteOctave;
}

function getPosition( inputNote:NoteOctave, notes:Array<Array<NoteOctave>> ) {
	final positions = [for( string in 0...notes.length )
		for( fret in 0...notes[string].length )
			if( notes[string][fret].compare( inputNote ))
				{ string: string, fret: fret }
	];
	
	positions.sort(( a, b ) -> {
		if( a.string < b.string ) return -1;
		if( a.string > b.string ) return 1;
		
		if( a.fret < b.fret ) return -1;
		if( a.fret > b.fret ) return 1;

		return 0;
	});

	return positions.length == 0 ? "no match" : positions.map( position -> '${position.string}/${position.fret}' ).join(" ");
}