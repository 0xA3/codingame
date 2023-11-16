package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1 = letter+ and #same, cw", Main.process( "9 topRight clockwise F4 G4" ).should.be( test1Result ));
			it( "Test 2 = letter+ and #same, ccw", Main.process( "11 topLeft counter-clockwise C15 D15" ).should.be( test2Result ));
			it( "Test 3 = letter++ and #same, cw", Main.process( "19 bottomRight clockwise B33 D33" ).should.be( test3Result ));
			it( "Test 4 = letter++ and #same, ccw", Main.process( "9 topLeft counter-clockwise E14 H14" ).should.be( test4Result ));
			it( "Test 5 = letter+ and #+, cw", Main.process( "19 topLeft clockwise C3 D4" ).should.be( test5Result ));
			it( "Test 6 = letter+ and #+, ccw", Main.process( "15 bottomRight counter-clockwise I4 J5" ).should.be( test6Result ));
			it( "Test 7 = letter+ and #++, cw", Main.process( "15 bottomRight clockwise E2 F5" ).should.be( test7Result ));
			it( "Test 8 = letter+ and #++, ccw", Main.process( "11 topLeft counter-clockwise A1 B4" ).should.be( test8Result ));
			it( "Test 9 = letter++ and #+, cw", Main.process( "9 bottomRight clockwise V20 X21" ).should.be( test9Result ));
			it( "Test 10 = letter++ and #+, ccw", Main.process( "25 topLeft counter-clockwise A59 E60" ).should.be( test10Result ));
			it( "Test 11 = letter++ and #++, cw", Main.process( "7 topLeft clockwise F3 I6" ).should.be( test11Result ));
			it( "Test 12 = letter++ and #++, ccw", Main.process( "21 topRight counter-clockwise A10 D80" ).should.be( test12Result ));
			it( "Test 13 = letter- and #+, cw", Main.process( "21 topRight clockwise Z1 Y2" ).should.be( test13Result ));
			it( "Test 14 = letter- and #+, ccw", Main.process( "25 topRight counter-clockwise Y2 X3" ).should.be( test14Result ));
			it( "Test 15 = letter-- and #++, cw", Main.process( "19 topLeft clockwise Z10 T25" ).should.be( test15Result ));
			it( "Test 16 = letter-- and #++, ccw", Main.process( "11 topRight counter-clockwise M30 I70" ).should.be( test16Result ));
			it( "Test 17 = letter+ and #-, cw", Main.process( "17 bottomRight clockwise M18 N17" ).should.be( test17Result ));
			it( "Test 18 = letter+ and #-, ccw", Main.process( "21 bottomRight counter-clockwise F40 G39" ).should.be( test18Result ));
			it( "Test 19 = letter-- and #--, cw", Main.process( "5 topRight clockwise Q9 M7" ).should.be( test19Result ));
			it( "Test 20 = letter-- and #--, ccw", Main.process( "29 topLeft counter-clockwise Z80 W73" ).should.be( test20Result ));
			it( "Test 21 = whoa, that's not enough material, cw", Main.process( "29 bottomRight clockwise A2 B3" ).should.be( test21Result ));
			it( "Test 22 - whoa, that's not enough material, ccw", Main.process( "25 bottomRight counter-clockwise N28 M27" ).should.be( test22Result ));
			it( "Test 23 = oversized", Main.process( "51 bottomLeft clockwise A100 B97" ).should.be( test23Result ));
			it( "Test 24 = very oversized", Main.process( "201 topLeft counter-clockwise X1000 W989" ).should.be( test24Result ));
		});

	}
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1Result = parseResult(
	"LLLLMMM F
	K     M F
	K QQQ N F
	K P Q N F
	K P R N G
	J P   N G
	J POOOO G
	J       G
	JIIIIHHHH" );

	final test2Result = parseResult(
	"C EEEEEEEEE
	C E       D
	C E GGGFF D
	C E G   F D
	C E G G F D
	C E G G F D
	C E GGG F D
	C F     F D
	C FFFFFFF D
	C         D
	CCCCCDDDDDD" );

	final test3Result = parseResult(
	"DDDDDDDDDDDDDDDDDDD
	D                 D
	D HHHHHHHHHHHHHHH D
	D H             H D
	B F JJJJJJJJJJJ H D
	B F J         J H D
	B F J LLLLLLL J H D
	B F J L     L J H D
	B F J L LLN L J H D
	B F J L L   L J H D
	B F J L LLLLL J H D
	B F J L       L H D
	B F J LLLLLLLLL H F
	B F J           H F
	B F JJJJJJJHHHHHH F
	B F               F
	B FFFFFFFFFFFFFFFFF
	B                  
	BBBBBBBBBBBBBBBBBBB" );

	final test4Result = parseResult(
	"E KKKHHHH
	E K     H
	E K NNN H
	E K N N H
	E K N N H
	E K   K H
	E KKKKK H
	E       H
	EEEEEEHHH" );

	final test5Result = parseResult(
	"CCCDDDDEEEEEFFFFFFG
	                  G
	LLLLLMMMMMMMMMMMM G
	L               M G
	L PPPPPPPQQQQQQ N G
	L P           Q N G
	L P RRSSSSSSS Q N G
	L P R       S Q N H
	L P R TTTTT S Q N H
	L P R T   T S Q N H
	K P R T TTT S Q N H
	K P R T     S Q N H
	K P R SSSSSSS Q N H
	K P R         Q N H
	K O RRRRRRRRRQQ N H
	K O             N I
	K OOOOOOOOOOOOONN I
	K                 I
	KKKJJJJJJJJJJIIIIII" );

	final test6Result = parseResult(
	"MMMMMMMLLLLLLLK
	M             K
	N RRRRRQQQQQQ K
	N R         Q K
	N R TTTTTTT Q K
	N R T     T Q K
	N R T UUU T Q J
	N R T U U T Q J
	N R T U U S Q J
	N R T   U S P J
	N R UUUUU S P J
	O S       S P I
	O SSSSSSSSS P I
	O           P I
	OOOOOOOPPPPPP I" );

	final test7Result = parseResult(
	"IIIIIIIIIIIIJJJ
	I             J
	I KLLLLLLLLLL J
	H K         L J
	H K MMMMMMM L J
	H K M     M L J
	H K M MMN M L J
	H K M M   M L J
	H K M MMMMM L J
	H K M       L J
	H K MMMLLLLLL J
	H K           J
	H KKKKKKKKKKJJJ
	H              
	GGGGGGGGFFFFFEE" );

	final test8Result = parseResult(
	"A FFFFEEEEE
	B F       E
	B F GGGGG E
	B F G   G E
	B F G H G E
	C F G G G E
	C F GGG G E
	C F     G E
	C FFFFFGG E
	C         D
	CCDDDDDDDDD" );

	final test9Result = parseResult(
	"VVVVXXXXX
	V       X
	V XZZZZ X
	V X   Z X
	V X ZZZ X
	V X     X
	V XXXXXXX
	V        
	VVVVVVVVV" );

	final test10Result = parseResult(
	"A EEEEEEEEEEEEEEEEEEEEEEE
	A E                     E
	A E IIIIIIIIIIIIIIIIIII E
	A E I                 I E
	A E I MMMMMMMMMMMMMMM I E
	A E I M             M I E
	A E I M QQQQQQQQQQQ M I E
	A E I M Q         Q M I E
	A E M Q Q UUUUUUU Q M I E
	A E M Q Q U     U Q M I E
	A E M Q Q U UUU U Q M I E
	A E M Q Q U U U U Q M I E
	A E M Q Q U U U U Q M I E
	A E M Q Q U   U U Q M I E
	A E M Q Q UUUUU U Q M I A
	A E M Q Q       U Q M I A
	A E M Q QQQQQQQQQ Q M I A
	A E M Q           Q M I A
	A E M QQQQQQQQQQQQQ M I A
	A E M               M I A
	A E MMMMMMMMMMMMMMMMM I A
	A E                   I A
	A EEEIIIIIIIIIIIIIIIIII A
	A                       A
	AAAAAAAAAAAAAAAAAAAAAAAAA" );

	final test11Result = parseResult(
	"FFFIIII
	      I
	OOOOO I
	O   O L
	O ROO L
	O     L
	OLLLLLL" );

	final test12Result = parseResult(
	"DDDDDDDDDDDAAAAAAAAAA
	D                    
	D GGGGGGGDDDDDDDDDDDD
	D G                 D
	D G GGGGGGGGGGGGGGG D
	D G G             G D
	D G G GGGGGGGGGGG G D
	D G G G         G G D
	D G G G GGGGGGG G G D
	D G G G G     G G G D
	D G G G G JGG G G G D
	D G G G G   G G G G D
	D G G G GGGGG G G G D
	D G G G       G G G D
	D G G GGGGGGGGG G G D
	D G G           G G D
	D G GGGGGGGGGGGGG G D
	D G               G D
	D GGGGGGGGGGGGGGGGG D
	D                   D
	DDDDDDDDDDDDDDDDDDDDD" );

	final test13Result = parseResult(
	"PPPPPPOOOOOOOOOOOON Z
	P                 N Y
	P KKKKKKKKJJJJJJJ N Y
	P K             J N X
	P K HHHHHHHHHHG J N X
	P K H         G J N X
	Q K H FFFFFFF G J N W
	Q K H F     F G J N W
	Q K H F EEE F G J N W
	Q K H F E E F G J N W
	Q K H F E E F G J N V
	Q L H F E   F G J N V
	Q L H F EEFFF G J N V
	Q L H G       G I M V
	Q L I GGGGGGGGG I M V
	Q L I           I M U
	R L IIIIIIIIIIIII M U
	R L               M U
	R LLLLLLLLMMMMMMMMM U
	R                   U
	RRRRRSSSSSSSSTTTTTTTU" );

	final test14Result = parseResult(
	"TTTTTUUUUUUVVVVVWWWWXXXYY
	T                        
	T LLLLLLLLLLLLLMMMMMMMMMM
	S L                     M
	S L GGGGHHHHHHHHHHHHHHH M
	S K G                 H M
	S K G DEEEEEEEEEEEEEE H M
	S K G D             E H N
	S K G D CCCCCCCCCCC E H N
	S K G D C         C E I N
	S K G D C ABBBBBB C E I N
	R K G D B A     B C E I N
	R K G D B A AAA B C E I N
	R K G D B A   A B C E I N
	R K G D B AAAAA B C E I N
	R K G D B       B C F I N
	R K G D BBBBBBBBB C F I N
	R K G D           C F I N
	R K G DDDDDDDDDDDCC F I N
	R K G               F I N
	Q K GFFFFFFFFFFFFFFFF I O
	Q J                   I O
	Q JJJJJJJJJJJJJJJJIIIII O
	Q                       O
	QQQQQQPPPPPPPPPPPOOOOOOOO" );

	final test15Result = parseResult(
	"ZZZZZZZZZZTTTTTTTTT
	                  T
	NNNNNHHHHHHHHHHHH T
	N               H T
	N HHHHBBBBBBBBB H T
	N H           B H T
	N H BBBBBBBBB B H T
	N H B       B B H T
	N H B BBBBB B B H T
	N H B B   B B B H T
	N H B B BBB B B H T
	N H B B     B B H T
	N H B BBBBBBB B H T
	N H B         B H T
	N H BBBBBBBBBBB H T
	N H             H T
	N HHHHHHHHHHHHHHH T
	N                 N
	NNNNNNNNNNNNNNNNNNN" );

	final test16Result = parseResult(
	"MMMMMMMMMMM
	M          
	M IIIIIIIII
	M I       I
	M I IIIII I
	M I I   I I
	M I III I I
	M I     I I
	M IIIIIII I
	M         I
	MMMMMMMMMMI" );

	final test17Result = parseResult(
	"NNNOOOOOOOOOOOOOO
	N               O
	N RRRRRSSSSSSSS O
	N R           S P
	N R VVVVVVVWW S P
	N R V       W S P
	N R V YYYYZ W S P
	N R U Y   Z W T P
	N R U Y ZZZ W T P
	N R U X     W T P
	N R U XXXXXXW T P
	N Q U         T P
	N Q UUUUUTTTTTT P
	N Q             P
	N QQQQQQQQQQQPPPP
	M                
	MMMMMMMMMMMMMMMMM" );

	final test18Result = parseResult(
	"GFFFFFFFFFFFFFFFFFFFF
	G                   F
	G HHHHHHHHHHHHHHHHH F
	G H               H F
	G H JJJJJJJJJJJJJ H F
	G H J           J H F
	G H J KKKKKKKKK J H F
	G I J K       K I H F
	G I J K LLLLL K I H F
	G I J K L   L K I H F
	G I J K L L L K I H F
	G I J K L L L K I H F
	G I J K LLL K K I H F
	G I J K     K K I H F
	G I J KKKKKKK K I H F
	G I J         K I H F
	G I JJJJJJJJJJK I H F
	G I             I H F
	G IIIIIIIIIIIIIII H F
	G                 H F
	GGGGGGGGGGGGGGGGGGG F" );

	final test19Result = parseResult(
	"MMM Q
	M M Q
	M I Q
	M   Q
	QQQQQ" );

	final test20Result = parseResult(
	"Z WWWWWWWWWWWWWWWWWWWWWWWWWWW
	Z W                         W
	Z W TTTTTTTTTTTTTTTTTTTTTTT W
	Z W T                     T W
	Z W T NNNNNNNNNQQQQQQQQQQ T W
	Z W T N                 Q T Z
	Z W T N KKKKKKKKKKKKKKK Q T Z
	Z W T N K             K Q T Z
	Z W T N K HHHHHHHHHHH K Q T Z
	Z W T N K H         H K Q T Z
	Z W T N K H EEEEEEE H K Q T Z
	Z W T N K H E     E H K Q T Z
	Z W T N K H E BBB E H K Q T Z
	Z W T N K H E B E E H N Q T Z
	Z W T N K H E B E E H N Q T Z
	Z W Q N K H E   E E H N Q T Z
	Z W Q N K H EEEEE E H N Q T Z
	Z W Q N K H       E H N Q T Z
	Z W Q N K HHHHHEEEE H N Q T Z
	Z W Q N K           H N Q T Z
	Z W Q N KKKKKKKKKKKHH N Q T Z
	Z W Q N               N Q T Z
	Z W Q NNNNNNNNNNNNNNNNN Q T Z
	Z W Q                   Q T Z
	Z W QQQQQQQQQQQQQQQQQQQQQ T Z
	Z W                       T Z
	Z WWWWWWWWWWWWWWWWWTTTTTTTT Z
	Z                           Z
	ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" );

	final test21Result = parseResult(
	"JJJJJJJJJKKKKKKKKKKKKLLLLLLLL
	J                           L
	J QQQQQQQQQQRRRRRRRRRRRRRRR L
	I Q                       R L
	I Q UUUUVVVVVVVVVVVVVVVVV R L
	I Q U                   V R L
	I Q U XXXXYYYYYYYYYYYYY V R M
	I Q U X               Y V S M
	I Q U X Z             Y V S M
	I Q U X Z             Y V S M
	I Q U X Z             Y V S M
	I P U X Z             Y W S M
	I P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X Z             Y W S M
	H P U X ZZZZZZZZZZZZZZZ W S N
	H P U X                 W S N
	G P U XXXXXXWWWWWWWWWWWWW S N
	G P T                     S N
	G P TTTTTTTTTTTTTTTTTTTTSSS N
	G P                         N
	G PPOOOOOOOOOOOOOOOONNNNNNNNN
	G                            
	GGFFFFFFFEEEEEEDDDDDCCCCBBBAA" );

	final test22Result = parseResult(
	"MMMMMMMMMMMMMMMMMMMMMNNNN
	M                       N
	M IIIIIIIJJJJJJJJJJJJJJ N
	M I                   J N
	M I FFFFFFFFFFFFFGGGG J N
	M I F               G J N
	M I F CCCCCCCCCCCCD G J N
	L I F C           D G J N
	L I F C     AAAAA D G J N
	L I F C         A D G J N
	L I F C         A D G J N
	L I F C         A D G J N
	L I E B         A D G J N
	L I E B         A D G K N
	L I E B         A D G K N
	L I E B         A D G K N
	L I E B         A D G K N
	L I E B         A D G K N
	L I E BBBBBBBBBBA D G K N
	L H E             D G K N
	L H EEEEEEEEEEEDDDD G K N
	L H                 G K N
	L HHHHHHHHHHHHHHHHHHH K N
	L                     K N
	LLLLLLLLLKKKKKKKKKKKKKK N" );

	final test23Result = parseResult(
	"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	A                              
	A CCCCCCCCCCCCCCCCCCCCCCCCCCCCC
	A C                            
	A C EEEEEEEEEEEEEEEEEEEEEEEEEEE
	A C E                          
	A C E GGGGGGGGGGGGGGGGGGGGGGGGG
	A C E G                        
	A C E G IIIIIIIIIIIIIIIIIIIIIII
	A C E G I                      
	A C E G I KKKKKKKKKKKKKKKKKKKKK
	A C E G I K                    
	A C E G I K LLLLLLLLLLLLLLLLMMM
	A C E G I K L                  
	A C E G I K L NNNNNNNNNNNNNNNNN
	A C E G I K L N                
	A C E G I J L N OOOOOOOOOOOOOOO
	A C E G I J L N O              
	A C E G I J L N O PPQQQQQQQQQQQ
	A C E G I J L N O P            
	A C E G I J L N O P QQRRRRRRRRR
	A C E G I J L N O P Q         R
	A C E G I J L N O P Q RRRRRRR R
	A C E G I J L N O P Q R     R R
	A C E G I J L N O P Q R SSS R R
	A C E G I J L N O P Q R S S R R
	A C E G I J L N O P Q R S S R R
	A C E G I J L N O P Q R S   R R
	A C E G I J L N O P Q R SSRRR R
	A C E G I J L N O P Q R       R
	A C E G I J L N O P Q RRRRRRRRR" );

	final test24Result = parseResult(
	"X XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	X X                            
	X X WWWWWWWWWWWWWWWWWWWWWWWWWWW
	X X W                          
	X X W VVVVVVVVVVVVVVVVVVVVVVVVV
	X X W V                        
	X X W V UUUUUUUUUUUUUUUUUUUUUUU
	X X W V U                      
	X X W V U UUUUUUUUUUUUUUUUUUUUU
	X X W V U U                    
	X X W V U U TTTTTTTTTTTTTTTTTTT
	X X W V U U T                  
	X X W V U U T SSSSSSSSSSSSSSSSS
	X X W V U U T S                
	X X W V U U T S RRRRRRRRRRRRRRR
	X X W V U U T S R              
	X X W V U U T S R RRRRRRRRRRRRR
	X X W V U U T S R R            
	X X W V U U T S R R QQQQQQQQQQQ
	X X W V U U T S R R Q          
	X X W V U U T S R R Q PPPPPPPPP
	X X W V U U T S R R Q P        
	X X W V U U T S R R Q P PPPPPPP
	X X W V U U T S R R Q P P      
	X X W V U U T S R R Q P P OOOOO
	X X W V U U T S R R Q P P O    
	X X W V U U T S R R Q P P O NNN
	X X W V U U T S R R Q P P O N  
	X X W V U U T S R R Q P P O N N
	X X W V U U T S R R Q P P O N N
	X X W V U U T S R R Q P P O N N" );
}
