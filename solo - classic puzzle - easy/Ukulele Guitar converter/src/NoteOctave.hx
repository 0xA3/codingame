@:structInit class NoteOctave {
	public final note:String;
	public final octave:Int;

	public function compare( other:NoteOctave ) return other.note == note && other.octave == octave;
	
	public function toString() return 'note: $note, octave: $octave';
}