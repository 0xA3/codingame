package test;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "N=3", { Main.process( 3 ).should.be( n3 ); });
			it( "N=9", { Main.process( 9 ).should.be( n9 ); });
			it( "N=15", { Main.process( 15 ).should.be( n15 ); });
			it( "N=21", { Main.process( 21 ).should.be( n21 ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final n3 = parseResult(
"#   #
    #
#    " );
	
	static final n9 = parseResult(
"        #   #    
  #           #  
#   #       #    
      #   #   #  
    #     # #   #
  #   #          
#       #        
  #       #      
#           #    " );
	
	static final n15 = parseResult(
"#       #   #                
              #   #          
#   #       #               #
              #   #       #  
    #   #           #   #   #
  #   #   #       #          
            #   #   #        
  #       #     # #   #   #  
    #   #   #                
      #       #              
    #   #       #       #   #
      #           #          
        #                    
  #           #       #      
#                       #    " );

	static final n21 = parseResult(
"#       #               #           #    
                  #       #   #       #  
    #           #                   #   #
      #       #   #                      
                    #   #           #    
      #   #       #               #      
                    #   #       #        
  #       #   #           #   #   #      
#   #   #   #   #       #               #
                  #   #   #              
        #       #     # #   #   #   #    
          #   #   #                      
            #       #                    
  #       #   #       #       #   #      
    #       #           #           #   #
              #                       #  
    #   #           #       #       #    
      #                       #          
#           #       #   #                
          #   #       #           #      
#                   #   #           #    " );
}
