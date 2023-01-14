package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test wordWrap", {
			it( "cat dog mouse", {
				Main.wordWrap( "cat dog mouse".split( "" ), 5 ).join( "" ).should.be( "cat\ndog\nmouse" );
			});
			it( "cat dog mouse", {
				Main.wordWrap( "cat dog mouse".split( "" ), 7 ).join( "" ).should.be( "cat dog\nmouse" );
			});
		});
		
		describe( "Test process", {
			it( "cat", {
				final ip = cat;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( "cat" );
			});
			it( "Welcome Message", {
				final ip = welcomeMessage;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( welcomeMessageResult );
			});
			it( "Urgent Message", {
				final ip = urgentMessage;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( urgentMessageResult );
			});
			it( "Yet Another Urgent Message", {
				final ip = yetAnotherUrgentMessage;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( yetAnotherUrgentMessageResult );
			});
			it( "shuffle", {
				final ip = shuffle;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( "fdbgeca" );
			});
			it( "Final Message", {
				final ip = finalMessage;
				Main.process( ip.swaps, ip.encodedMessage ).should.be( finalMessageResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final n = parseInt( lines[0] );
		final swaps = [for( i in 0...n ) lines[i + 1]];
		
		final length = parseInt( lines[n + 1] );
		final encodedMessage = lines[n + 2];
	
		return { swaps: swaps, encodedMessage: encodedMessage };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final cat = parseInput(
	"0
	3
	t+c+*+a+*+*" );

	final welcomeMessage = parseInput(
	"13
	v -> m
	e -> v
	g -> e
	l -> g
	s -> l
	f -> h
	a -> f
	y -> a
	z -> y
	i -> z
	k -> i
	m -> s
	h -> k
	1419
	m+g+W+*+*+k+s+*+t+ +g+v+o+c+*+*+*+*+o+t+ +*+*+*+*+*+ +g+f+*+*+*+m+g+r+*+*+*+*+*+s+y+t+*+*+g+g+c+n+*+*+*+u+o+Y+ +!+*+*+*+*+*+f+ +r+*+*+*+*+*+m+k+p+*+ +*+*+*+o+.+y+k+g+r+g+r+l+ +*+*+*+*+s+t+y+*+*+*+z+*+p+p+y+ +*+*+*+*+*+*+c+*+*+*+t+*+d+g+*+*+*+a+n+U+ +*+*+*+*+*+k+n+s+g+n+u+t+r+*+*+*+*+t+y+*+*+*+*+S+ +,+z+*+*+*+*+*+y+l+y+z+p+o+o+*+*+*+*+ +f+ +*+*+o+ +m+y+*+*+*+*+g+c+n+*+*+*+*+*+*+*+*+B+ + +m+ + +n+*+*+n+g+g+b+*+*+*+*+*+*+n+t+o+f+*+*+*+w+o+d+ +*+*+*+*+*+*+g+z+b+*+*+f+t+ +*+*+*+*+R+ +*+*+d+g+*+*+*+*+f+ +r+y+*+*+ +n+o+*+*+*+z+ +d+n+y+*+*+*+*+*+r+u+o+*+*+*+*+*+r+o+d+g+g+k+ +p+s+g+*+*+*+*+*+g+n+ +m+*+*+*+*+*+d+*+*+*+w+g+r+y+W+ +.+*+*+*+ +g+*+*+*+*+*+ +*+*+*+*+p+m+g+d+ +k+h+*+*+l+n+*+*+*+*+*+*+*+g+*+z+s+g+y+r+*+*+t+*+*+*+*+g+d+ +*+o+t+*+*+ +*+*+*+ +y+f+k+v+r+g+t+*+*+*+*+*+ +g+n+*+*+*+*+ +m+k+*+*+s+ +*+*+n+o+k+t+y+c+o+*+*+*+*+*+*+*+*+*+d+n+*+*+*+o+o+c+*+*+*+c+y+ +n+d+r+*+*+y+t+y+n+k+*+*+*+*+ +g+*+*+*+*+*+t+x+g+*+*+*+r+*+*+*+m+o+k+t+*+*+*+o+t+ +d+ +g+p+ +n+*+*+*+W+ +n+y+s+*+*+*+.+*+*+*+*+*+g+g+n+*+*+*+*+*+*+*+o+u+c+m+g+r+ +*+*+*+*+*+*+ +g+*+*+o+n+S+*+*+*+*+s+s+y+r+g+b+ +z+p+*+*+*+*+*+o+a+*+*+*+f+ +g+*+*+*+ +g+*+*+a+*+*+*+*+*+g+g+ +o+t+n+k+ +*+*+*+*+*+*+*+g+h+ +z+v+g+n+*+*+*+*+*+n+y+f+*+*+*+!+m+d+*+*+*+ +y+g+s+P+ +*+*+*+*+*+g+m+*+*+*+*+*+*+v+o+c+ +p+*+*+*+*+v+*+*+o+k+c+k+n+u+*+*+*+*+t+y+*+*+*+*+o+ +n+*+m+*+*+*+p+*+ + + +n+g+*+*+*+d+n+y+*+*+*+*+z+d+ +b+*+g+*+*+y+g+r+*+*+*+*+*+o+t+ +*+*+*+*+!+g+o+v+*+*+e+*+*+*" );

	final welcomeMessageResult = parseResult(
	"Welcome to the resistance! Your help is greatly appreciated. Unfortunately,
	Snoopy has once again been shot down by the Red Baron and your help is
	needed. We are working desperately to determine his location and coordinate
	an extraction plan. We need to rescue Snoopy before he falls into enemy
	hands! Please keep communications open and be ready to move!" );

	final urgentMessage = parseInput(
	"12
	p -> t
	h -> p
	l -> h
	z -> l
	g -> z
	v -> q
	u -> v
	i -> u
	s -> i
	c -> s
	t -> g
	q -> c
	2515
	q+o+e+n+E+*+*+*+f+ +y+m+*+*+*+*+*+r+*+*+c+e+*+*+o+e+r+a+ +*+*+*+*+m+ +*+*+*+n+e+w+ +u+*+s+*+t+n+*+*+*+*+*+q+ +n+a+ +p+c+*+*+*+*+*+e+ +e+w+ +d+*+*+*+*+*+r+a+*+*+*+*+*+r+e+q+n+o+*+*+*+*+*+ +e+n+*+*+d+*+*+e+e+'+y+h+n+S+*+*+o+o+*+*+*+*+*+b+ +p+s+o+h+ +c+*+*+*+*+c+*+*+*+o+s+*+*+ +n+*+*+c+a+l+*+*+*+*+*+*+*+*+o+q+ +*+*+*+h+m+*+*+n+ +.+d+e+c+s+m+o+r+*+*+*+*+*+*+*+*+*+I+*+*+d+ +*+r+o+*+*+*+f+e+e+o+p+ +r+e+*+*+*+*+*+b+ +*+*+*+*+*+e+c+ +h+i+ +*+*+*+*+*+*+z+y+s+r+i+q+*+*+*+*+p+*+*+ +n+,+*+a+ +*+*+*+*+d+d+a+*+*+*+a+n+o+s+p+s+*+*+*+*+*+*+*+r+ +*+*+ +i+*+e+b+l+ +e+z+*+*+*+*+ +c+a+*+*+*+*+*+d+ +n+e+*+*+*+a+*+*+n+c+o+e+l+e+d+*+*+p+o+p+ +d+*+*+*+*+ +*+*+*+*+q+e+d+ +*+*+*+*+*+b+e+z+ +t+n+s+d+*+*+*+*+*+i+r+*+*+*+*+o+ +h+U+ +.+c+*+*+*+*+*+n+o+*+*+*+*+*+*+s+u+r+e+*+*+*+*+*+l+c+a+ +a+ +t+*+*+*+*+l+*+*+*+*+*+a+a+ +p+*+,+t+a+*+*+*+*+*+r+e+q+ +*+*+*+*+p+*+*+ +d+s+*+r+m+i+n+ +n+*+*+*+*+*+e+b+*+*+*+ +*+l+q+ +f+o+*+*+*+*+*+r+a+*+*+z+o+l+r+e+p+q+a+*+*+*+*+*+c+ +c+*+*+*+*+*+i+*+*+*+*+e+e+b+*+d+ +e+*+*+*+*+e+p+e+z+*+*+*+*+ +d+*+o+r+f+ +*+*+*+*+l+ +m+*+*+p+*+*+p+c+s+ +e+*+*+z+*+*+*+*+*+o+m+ +f+o+*+*+*+*+*+r+ +p+c+*+*+*+*+*+z+p+n+e+q+*+*+*+*+*+u+ +y+*+*+r+e+o+*+c+b+*+*+*+*+*+c+e+*+l+q+d+*+ +*+*+*+p+q+a+r+a+*+*+*+*+*+i+ +(+ +c+r+e+*+*+*+*+*+l+p+*+*+l+ +p+a+*+*+*+*+n+e+u+a+*+*+*+e+e+ +e+y+n+ +*+*+ +p+o+*+*+*+*+*+p+*+*+b+*+*+*+*+*+*+*+d+e+*+*+p+ +r+z+a+s+d+m+.+)+*+*+m+I+ +*+*+*+*+e+*+*+*+*+e+p+*+*+*+f+a+ +y+*+*+*+*+e+p+*+*+*+l+c+l+p+ +*+*+*+a+l+ +e+*+*+*+*+*+*+*+*+ +z+z+s+ +t+a+*+*+*+w+*+*+*+*+e+b+ +*+*+*+*+a+*+t+s+z+c+ +*+*+t+n+s+*+*+*+*+e+*+t+s+d+ +*+*+*+*+*+e+s+ +p+*+*+*+p+n+*+*+*+*+ +r+e+*+*+*+w+p+e+b+*+*+*+*+e+*+ +1+ +n+e+*+*+*+*+*+l+d+n+s+ + +d+n+a+*+*+*+*+9+*+*+*+*+*+ +t+s+*+n+s+p+a+q+*+*+*+*+*+*+*+*+i+c+l+p+ +f+a+m+ +w+o+*+*+*+*+*+ +y+n+*+*+*+o+*+*+*+*+*+e+p+c+o+m+ +e+*+*+*+*+*+*+e+q+e+r+ +*+*+*+*+*+p+n+*+*+ +y+z+*+*+*+a+l+q+o+*+b+*+ +d+e+e+c+*+*+u+r+*+*+*+*+*+*+*+*+p+q+a+r+*+*+*+*+*+ +c+r+*+*+*+*+o+l+*+*+*+(+ +.+ +e+z+*+b+ +d+*+*+*+*+*+d+e+p+e+z+e+d+*+*+*+*+*+*+*+*+*+*+a+l+*+*+t+a+p+ +l+c+*+*+*+*+*+*+m+m+ +1+)+*+*+*+*+r+d+ +c+e+*+n+a+*+*+*+*+*+s+f+p+e+z+e+*+*+*+*+ +e+l+p+ +e+*+*+*+*+*+*+*+*+*+ +p+c+*+*+*+*+ +y+z+p+c+o+*+*+*+p+e+q+e+r+ +*+*+*+*+*+n+*+*+*+*+*+c+b+o+*+*+*+w+ +d+e+u+r+e+*+*+*+*+*+*+(+ +.+r+q+*+e+p+q+a+r+a+l+*+*+*+*+*+*+*+*+*+*+*+ +2+c+a+l+*+*+*+)+t+a+p+l+*+ +*+*+*+*+*+*+*+a+e+m+*+*+*+p+d+ +c+n+*+*+*+*+e+l+p+e+z+e+*+*+*+*+p+ +e+*+*+*+*+*+ +*+*+*+o+*+o+m+ +*+*+*+.+q+e+r+ +p+c+*+*+*+*+*+e+e+q+*+*+u+r+e+z+p+n+*+*+*+c+b+y+*+o+ +*+*+*+*+*+*+*+*+ +d+*+*+*+c+r+q+a+r+a+l+*+*+*+*+*+e+p+*+*+*+*+*" );

	final urgentMessageResult = parseResult(
	"Enemy forces are moving west and we are concerned Snoopy's position has
	been compromised. In order to beef up security, an additional rule has been
	added to the decoding rules. Upon observing a hash tag, a certain number of
	characters should be deleted from the list of most recently observed
	characters (that have not yet been used). Immediately after the hash tag
	will be a single digit integer between 1 and 9 indicating how many of the
	most recently observed characters should be deleted. (hash tag)1 means
	delete the first most recently observed character. (hash tag)2 means delete
	the two most recently observed characters." );
	
	final yetAnotherUrgentMessage = parseInput(
	"14
	e -> h
	p -> e
	w -> p
	y -> w
	c -> y
	n -> c
	v -> b
	z -> v
	k -> z
	t -> k
	u -> t
	f -> u
	h -> n
	b -> f
	3789
	 +q+#1+n+s+#2+h+O+i+#1+*+*+g+r+ +h+p+ +u+ +p+v+s+#2+*+*+s+a+l+*+*+*+*+*+ +c+p+d+k+o+h+#3+p+b+l+#5+p+s+e+x+#2+*+*+u+i+r+f+n+b+v+t+#3+*+*+*+*+*+*+*+p+v+ +s+a+e+ +p+c+g+#2+r+f+s+i+a+p+m+*+*+*+g+x+i+#4+*+*+*+*+*+*+*+*+*+*+*+*+*+*+f+d+a+*+*+o+ +d+p+d+i+#1+*+*+x+#1+*+o+ +*+u+*+*+*+*+*+*+h+i+d+o+n+h+p+ +t+j+#2+*+*+*+*+*+g+t+t+f+n+#5+*+*+*+*+*+a+n+s+*+*+e+p+m+q+p+e+*+*+c+#2+*+*+u+ +m+#1+*+*+*+*+u+j+b+u+e+l+#5+*+ +m+ +d+n+#2+*+*+p+z+v+ +u+s+f+t+n+i+#3+*+*+*+*+*+#1+*+*+d+h+i+v+b+t+#3+*+*+f+l+n+p+o+m+o+#4+*+*+*+*+d+d+p+*+*+ +r+c+ +h+i+ +i+n+h+n+s+#5+*+*+*+*+*+f+o+*+*+*+*+*+i+d+o+n+p+t+c+j+#3+*+*+*+*+*+r+ +h+j+v+z+o+#4+*+g+*+*+w+l+f+r+l+g+e+#3+*+*+*+U+ +p+g+h+j+q+y+#5+*+.+s+p+f+#2+*+*+*+*+*+o+ +h+o+*+*+*+*+p+s+v+*+*+*+*+.+z+*+r+a+ +i+*+g+h+q+#1+*+*+*+*+w+ +*+*+p+t+#1+*+*+z+r+n+p+u+h+p+n+*+*+*+*+e+u+ +,+g+i+s+ +*+*+*+*+h+*+*+*+*+*+r+ +p+p+#1+*+*+*+*+*+o+ +c+l+h+p+k+#1+*+*+u+*+*+*+*+*+p+s+v+i+p+o+c+v+#5+*+*+*+*+*+p+ +e+n+ +d+p+p+z+q+#3+*+*+*+*+*+s+r+n+a+r+a+r+o+#2+*+*+*+*+p+u+*+*+*+*+*+h+f+#1+*+*+d+d+p+u+i+#2+*+*+v+ +o+u+ +*+*+*+*+*+p+l+b+s+b+f+p+*+e+s+ +a+b+a+s+j+#5+*+*+*+*+*+w+j+#3+*+*+*+*+*+f+T+ +*+*+a+n+ +p+f+e+s+ +o+*+*+*+*+*+e+ +p+l+b+b+*+*+*+*+*+u+*+*+*+*+*+r+a+e+c+x+g+e+#4+*+*+*+*+s+ +,+s+r+p+u+n+k+#1+*+*+*+*+r+e+#2+*+*+*+*+#1+a+u+p+q+i+c+#4+*+*+ +u+r+*+*+*+k+k+#2+u+i+y+*+*+o+ + +e+u+*+*+*+p+e+u+i+#1+*+*+*+*+*+e+s+a+#1+p+d+l+*+*+*+*+n+ +u+*+*+*+*+i+x+s+#4+s+u+a+*+u+ + +r+n+a+r+*+*+*+u+l+a+t+c+#4+*+p+k+f+b+g+k+#5+*+*+*+u+s+p+y+l+g+x+e+u+(+*+r+f+b+*+*+*+*+*+#4+*+*+*+*+*+ +o+*+*+*+x+l+ +p+e+*+*+*+*+#1+i+i+ +u+b+p+*+*+*+*+*+ +h+t+#1+*+f+p+e+u+ +*+*+*+*+g+#2+*+l+*+*+b+z+#2+*+d+ +)+u+o+y+r+e+r+#5+*+*+*+h+a+*+*+*+l+n+r+a+d+ +d+d+a+ +*+*+*+*+*+h+2+c+r+p+z+p+*+u+q+b+t+#4+*+*+*+*+ +v+q+#2+*+*+*+*+e+n+ +*+*+*+*+*+p+u+n+a+*+*+*+*+t+n+#4+e+r+*+z+j+g+l+b+#5+u+ +l+i+u+h+f+ +*+*+*+*+*+*+*+*+*+i+p+ +p+*+*+o+j+t+l+#4+*+ +a+h+ +d+h+*+*+*+i+#3+p+b+o+*+*+e+u+ +a+a+#2+*+*+*+*+*+l+*+*+p+e+u+T+ +.+u+s+*+*+*+*+*+d+h+p+e+g+x+i+m+w+#5+*+*+*+d+a+ +*+*+*+*+ +*+*+*+o+d+h+2+ +p+*+*+*+*+*+ +r+s+#2+*+*+t+r+v+a+j+#4+ +p+e+u+ +p+m+ +b+u+s+p+d+l+b+#1+*+*+*+*+*+o+ +j+n+p+a+f+#5+*+ +d+u+h+z+f+n+*+ +j+a+h+a+n+a+r+a+e+*+*+*+*+*+x+p+u+k+#1+*+*+l+j+p+o+#5+ +r+r+i+d+j+s+#5+*+*+*+*+ +d+*+*+*+d+h+x+j+k+o+o+n+z+r+#4+r+d+d+*+*+p+z+p+ +*+*+*+*+*+d+s+m+j+#5+#3+2+ +c+n+g+#2+*+*+*+*+*+l+p+h+r+m+v+o+k+a+#5+a+e+n+ +*+*+*+*+*+r+p+u+n+a+*+*+*+*+*+u+#5+*+*+l+j+i+g+#1+#4+*+*+h+u+ +i+z+f+d+w+j+#5+*+l+*+*+*+n+#1+p+ +p+e+a+c+g+j+i+#5+*+*+*+*+*+*+*+*+*+*+ +p+e+u+*+*+*+*+f+l+j+s+u+s+i+l+*+*+*+*+s+A+ +.+*+*+*+*+*+i+k+#4+*+*+*+*+*+u+v+#2+*+*+*+s+i+l+*+*+*+n+u+y+#1+*+r+ +o+ +j+h+i+#3+*+*+b+z+b+h+#3+*+*+*+p+*+*+z+r+p+s+v+c+l+p+*+u+h+*+*+*+*+o+ +*+r+z+q+p+e+#5+*+*+*+*+*+*+#1+*+o+s+u+r+d+*+a+e+n+ +e+x+o+v+#4+*+*+*+*+*+ +s+r+p+u+n+a+r+f+e+#3+*+*+*+*+*+*+*+*+#1+*+v+ +*+*+ +,+ +,+a+ +p+*+*+*+*+*+v+h+b+h+e+s+#5+*+*+*+ + +,+n+j+e+b+q+#4+*+*+*+e+l+u+p+b+ +p+ +,+d+*+*+*+*+,+*+*+*+r+p+e+y+ +g+ +,+j+#1+*+*+*+*+*+l+k+#2+*+q+o+c+r+m+#5+*+*+*+g+ +*+*+r+d+p+l+#4+#3+*+i+*+p+s+t+#1+*+n+ +p+e+u+ +*+*+*+*+*+p+r+ +u+m+f+q+w+m+#5+s+o+m+b+p+z+g+#4+*+*+*+*+*+*+*+*+*+h+*+o+b+y+p+h+ +l+u+*+*+ +d+h+s+c+*+ +p+s+v+o+ +*+*+*+*+*+b+a+ +r+ +d+p+z+r+*+*+*+*+*+p+n+a+i+p+c+k+r+a+e+n+o+q+#2+*+*+*+*+#4+*+*+u+c+g+l+h+g+v+#3+b+#4+*+*+*+*+*+ +d+h+*+*+*+*+*+i+*+*+2+y+ +p+s+e+ +a+#1+*+u+p+y+#2+*+*+t+n+#3+*+*+l+y+x+#4+*+*+*+*+p+ +.+r+p+u+u+n+o+ +h+s+o+m+g+#1+*+*+*+ +u+*+*+p+r+f+r+h+#3+*+*+p+n+p+j+#2+*+*+*+p+c+l+u+t+k+d+h+#4+*+*+*+#1+*+*+g+z+r+v+f+q+#2+*+p+s+o+#1+*+*+*+c+#1+*+g+a+n+ +d+p+d+d+o+j+#4+*+*+*+*+r+a+e+*+*+*+*+z+s+#4+*+#1+*+*+*+*+*+n+t+g+e+T+c+m+b+c+m+#5+*+*+s+#4+*+*+*+*+*+b+f+o+n+e+s+ +b+#1+*+*+*+e+s+#4+*+*+*+y+ +u+s+l+y+#1+*+i+l+ +d+p+*+*+*+*+*+*+*+*+*+*+ +p+v+ +d+l+f+o+n+z+#3+*+*+*+*+*+*+*+,+n+q+b+ +,+a+*+*+*+#2+*+*+i+p+ +o+u+x+#3+*+*+e+s+g+ +,+f+#1+*+*+*+#2+f+,+v+ +,+t+#1+*+*+*+*+,+d+ +a+c+v+a+#4+*+*+*+o+#3+.+b+ +*+*+*" );

	 final yetAnotherUrgentMessageResult = parseResult(
	"One last security measure has been added to our encoding scheme that must
	be included in your decoding rules. Upon observing a percent sign, the
	recently observed characters need to be shuffled. To shuffle the
	characters, start with the oldest character (furthest to the left in the
	list) and add every 2nd character until the end of the list. Then add the
	2nd oldest character and add every 2nd character until the end of the list.
	Assume the list of recently observed characters to be a, b, c, d, e, f, g
	where g is the most recently observed character and f is the 2nd most
	recently observed character. The new shuffled list would be a, c, e, g, b,
	d, f." );
	
	final shuffle = parseInput(
	"0
	7
	abcdefg%*******" );

	final finalMessage = parseInput(
	"11
	g -> o
	b -> g
	x -> b
	q -> x
	k -> z
	i -> k
	w -> i
	d -> w
	p -> d
	o -> q
	z -> p
	1885
	e+n+%+w+g+l+C+b+%+*+*+*+*+u+t+a+r+*+*+*+*+*+t+a+u+h+z+#1+#2+*+*+*+w+h+g+*+x+T+g+!+s+n+g+l+#2+*+*+*+l+Y+x+ +a+p+v+q+n+q+ +s+n+#2+l+d+n+k+%+#5+*+*+*+u+n+e+e+h+ +r+u+*+*+n+n+u+#3+*+*+s+l+e+k+#1+*+*+a+h+ +z+p+l+m+v+#4+*+*+*+*+*+x+ +*+*+*+*+*+#5+*+w+y+o+c+i+n+#5+*+*+*+*+a+u+l+*+*+*+*+*+ +.+e+g+w+r+e+#4+*+*+*+z+s+s+#3+*+*+*+t+p+e+e+ +R+g+ +g+%+b+u+#2+*+*+*+*+r+a+B+ +s+j+q+z+#4+*+*+*+*+*+v+y+k+m+d+d+#5+a+ +t+s+a+h+ +n+*+*+*+*+*+m+#2+*+*+e+r+b+j+#1+*+*+*+t+ +p+e+*+*+*+*+i+t+x+x+#5+h+m+n+e+#4+*+*+e+m+*+*+*+*+C+y+S+w+d+ +*+*+*+h+t+*+*+ +*+*+c+z+t+g+e+g+n+*+a+b+p+j+u+e+p+%+#3+*+*+*+*+n+g+c+v+y+ +g+t+ +*+*+*+*+m+#3+*+*+*+*+*+%+z+c+ +%+#2+*+*+n+n+p+#3+*+*+*+e+t+h+ +r+e+c+a+*+*+e+%+*+*+*+*+G+n+a+i+l+*+*+ +s+o+s+#2+*+*+*+*+ +r+e+t+x+t+ +p+d+c+m+r+f+#5+*+*+*+v+s+k+r+ +e+h+z+u+#2+*+*+*+g+t+i+a+b+%+#4+#3+*+*+*+*+*+u+P+ +*+*+*+n+w+i+z+m+v+s+#2+*+*+*+*+*+a+%+#2+*+*+*+*+x+ +*+*+*+*+u+d+a+#3+s+s+a+ + +q+n+c+%+*+*+*+*+o+e+i+f+#1+*+*+a+%+#5+t+x+r+d+o+p+w+q+i+#3+*+f+v+b+#5+g+f+ +*+*+*+*+ +g+a+r+%+#3+d+e+i+n+ +a+ +p+b+l+#3+*+*+*+*+#1+*+*+*+ +x+e+%+*+*+*+l+t+*+*+*+*+.+n+a+l+z+*+*+*+*+*+*+*+g+l+a+e+p+z+a+m+r+h+*+*+t+s+h+w+e+f+m+r+v+#5+*+t+d+m+m+#5+*+*+*+*+l+p+s+v+x+ +s+*+*+*+l+%+#3+*+*+*+*+f+x+#4+r+v+n+m+ +e+ +s+ +,+*+*+g+h+t+*+*+*+*+e+f+u+#2+*+*+d+w+s+r+ +C+%+*+h+u+h+n+#3+*+*+*+t+b+s+x+m+o+z+j+#3+%+#1+*+*+*+*+s+v+b+z+l+d+l+h+y+b+%+#4+*+*+*+*+,+o+v+s+l+l+*+*+*+x+%+#1+*+b+b+n+w+r+ +y+f+q+p+#4+*+*+*+w+p+l+j+#2+b+t+b+l+p+o+p+f+ +%+#5+*+%+#5+*+*+*+*+*+h+t+*+*+*+l+z+b+o+l+#4+n+ +n+d+w+ +h+b+u+g+*+*+*+*+e+h+t+ +*+*+*+*+*+a+b+g+p+n+a+l+j+b+c+#3+*+*+*+*+f+x+t+,+m+l+z+ +y+ +B+g+ +e+.+%+*+*+*+n+w+r+p+g+a+r+#4+*+*+*+#5+*+*+%+*+*+*+*+*+a+r+v+r+l+ +c+a+*+*+i+ +g+t+ +e+*+*+*+*+*+o+l+%+#4+*+*+l+a+x+k+c+t+i+l+*+o+w+q+y+l+n+p+t+%+#5+ +e+h+t+ +s+#1+*+*+*+*+*+b+#5+*+*+t+y+p+%+#2+*+l+i+o+x+n+#4+*+*+*+#5+*+p+a+g+%+*+v+r+#3+*+*+*+*+w+#5+*+*+*+*+*+o+p+#5+*+*+*+*+%+t+*+*+h+!+n+i+b+v+#3+a+m+ +*+*+*+*+*+#1" );
	
	final finalMessageResult = parseResult(
	"Congratulations! Your help has been invaluable. The Red Baron has agreed to
	meet with Snoopy to conduct peace talks and the Great Pumpkin has been
	asked for a new battle plan. Christmas bells, those Christmas bells,
	ringing through the land. Bringing peace to all the world, and good will to
	man!" );
}
