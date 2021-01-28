package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Two 45", {
				final input = two45;
				Main.process( input.size, input.lines, input.angle ).should.be( two45Result );
			});
			
			it( "Shine Bright like a Dimond", {
				final input = shineBrightLikeADimond;
				Main.process( input.size, input.lines, input.angle ).should.be( shineBrightLikeADimondResult );
			});
			
			it( "Small random 1", {
				final input = smallRandom1;
				Main.process( input.size, input.lines, input.angle ).should.be( smallRandom1Result );
			});
			
			it( "Small random 2", {
				final input = smallRandom2;
				Main.process( input.size, input.lines, input.angle ).should.be( smallRandom2Result );
			});
			
			it( "Large random", {
				final input = largeRandom;
				Main.process( input.size, input.lines, input.angle ).should.be( largeRandomResult );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { size: parseInt( lines[0] ), lines: lines.slice( 2 ).map( line -> line.split(" ")), angle: parseInt( lines[1] )};
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final two45 = parseInput(
		"2
		45
		1 2
		3 4"
	);

	final two45Result = parseResult(
		" 2 
		1 4
		 3 "
	);

	final two135 = parseInput(
		"2
		125
		1 2
		3 4"
	);

	final two135Result = parseResult(
		" 2 
		1 4
		 3 "
	);

	final shineBrightLikeADimond = parseInput(
		"5
		45
		# # # # #
		# - . . #
		# # - . #
		# # # - #
		# # # # #"
	);

	final shineBrightLikeADimondResult = parseResult(
	"    #    
	   # #   
	  # . #  
	 # . . # 
	# - - - #
	 # # # # 
	  # # #  
	   # #   
	    #    "
	);
	
	final smallRandom1 = parseInput(
		"12
		495
		A A H G S R U B J Q B O
		N W E D L M M V T L U H
		R S D N B N Y W A T O O
		D L D Z V A R C C D I Q
		R P N F E Q I C I I D G
		H V K S Y Z P C N S I C
		X G J Y T L V B S Y Q B
		Y Q Z J Q N I T R D X E
		L U U M T D H D H R V E
		L M Z M R V T V D G E N
		G Q A X E Y B J D H A J
		R A M K O U J O G V U Z"
	);

	final smallRandom1Result = parseResult(
"           Z           
          J U          
         N A V         
        E E H G        
       E V G D O       
      B X R D J J      
     C Q D H V B U     
    G I Y R D T Y O    
   Q D S S T H V E K   
  O I I N B I D R X M  
 H O D I C V N T M A A 
O U T C C P L Q M Z Q R
 B L A C I Z T J U M G 
  Q T W R Q Y Y Z U L  
   J V Y A E S J Q L   
    B M N V F K G Y    
     U M B Z N V X     
      R L N D P H      
       S D D L R       
        G E S D        
         H W R         
          A N          
           A           "
	);

	final smallRandom2 = parseInput(
		"12
		405
		Q Q D R L F C Z O V A J
		W U T K S B B S W X N H
		A M B C O W X A M I I Y
		D H I D R F G G L L M J
		O O O P U O A E Q F N N
		N O H S O C P W H J W Z
		I M V J A R M L R Q F B
		U B H F F U B I Y U H N
		B S M W X D I H N I Y E
		P Y R G H K R W U C W A
		N C D H O J M K S Q P G
		M C G L U S C Y Y C J L"
	);

	final smallRandom2Result = parseResult(
"           J           
          A H          
         V N Y         
        O X I J        
       Z W I M N       
      C S M L N Z      
     F B A L F W B     
    L B X G Q J F N    
   R S W G E H Q H E   
  D K O F A W R U Y A  
 Q T C R O P L Y I W G 
Q U B D U C M I N C P L
 W M I P O R B H U Q J 
  A H O S A U I W S C  
   D O H J F D R K Y   
    O O V F X K M Y    
     N M H W H J C     
      I B M G O S      
       U S R H U       
        B Y D L        
         P C G         
          N C          
           M           "
	);

	final largeRandom = parseInput(
		"16
		315
		G W A U V V U E O J X I Z I H A
		T B Z K Y U B Y C W Z E M Z B F
		C P E A H U V O I L Y H P J U H
		G T C J M C N H Q U G M M H N H
		F D B G K B T E N R B Y S A U R
		M G R V E D W B D R U N J E F Y
		Y F F F I P O I D M Y I Z O Q X
		O L T I P Y I Q V D S M G S Y C
		H I V A U C U E Q X Y F I W W K
		M O N I S W M G I H Q N H R L J
		H S Z C V Q B B W N D Y K N Z D
		H I B N Q R V Z A E F L P J G M
		W U Z A T K X W G N K M U P R Q
		W X I U H D S Y Z K N F L E W H
		R Y U B N U E M F T N U I S T H
		X Q T E Z O U E B Z W D X X O E"
	);

	final largeRandomResult = parseResult(
"               G               
              T W              
             C B A             
            G P Z U            
           F T E K V           
          M D C A Y V          
         Y G B J H U U         
        O F R G M U B E        
       H L F V K C V Y O       
      M I T F E B N O C J      
     H O V I I D T H I W X     
    H S N A P P W E Q L Z I    
   W I Z I U Y O B N U Y E Z   
  W U B C S C I I D R G H M I  
 R X Z N V W U Q D R B M P Z H 
X Y I A Q Q M E V M U Y M J B A
 Q U U T R B G Q D Y N S H U F 
  T B H K V B I X S I J A N H  
   E N D X Z W H Y M Z E U H   
    Z U S W A N Q F G O F R    
     O E Y G E D N I S Q Y     
      U M Z N F Y H W Y X      
       E F K K L K R W C       
        B T N M P N L K        
         Z N F U J Z J         
          W U L P G D          
           D I E R M           
            X S W Q            
             X T H             
              O H              
               E               "
	);

}

