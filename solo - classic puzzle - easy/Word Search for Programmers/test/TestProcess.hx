package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Horizontal", {
				final ip = horizontal;
				Main.process( ip.rows, ip.clues ).should.be( horizontalResult );
			});
			it( "Vertical", {
				final ip = vertical;
				Main.process( ip.rows, ip.clues ).should.be( verticalResult );
			});
			it( "Diagonal", {
				final ip = diagonal;
				Main.process( ip.rows, ip.clues ).should.be( diagonalResult );
			});
			it( "The Simpsons", {
				final ip = theSimpsons;
				Main.process( ip.rows, ip.clues ).should.be( theSimpsonsResult );
			});
			it( "Famous Animals", {
				final ip = famousAnimals;
				Main.process( ip.rows, ip.clues ).should.be( famousAnimalsResult );
			});
			it( "US Presidents", {
				final ip = usPresidents;
				Main.process( ip.rows, ip.clues ).should.be( usPresidentsResult );
			});
			it( "Populous Countries", {
				final ip = populousCountries;
				Main.process( ip.rows, ip.clues ).should.be( populousCountriesResult );
			});
			it( "Many people with one name", {
				final ip = manyPeopleWithOneName;
				Main.process( ip.rows, ip.clues ).should.be( manyPeopleWithOneNameResult );
			});
			it( "Older Countries: Median age over 40", {
				final ip = olderCountries;
				Main.process( ip.rows, ip.clues ).should.be( olderCountriesResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final size = parseInt( lines[0] );
		final rows = [for( i in 0...size ) lines[i + 1].split( "" )];
		final clues = lines[size + 1].split(" ");
		
		return { rows: rows, clues: clues };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final horizontal = parseInput(
		"1
		ABC
		ABC" );

	final horizontalResult = parseResult(
		"ABC" );

	final vertical = parseInput(
		"3
		A
		B
		C
		ABC" );

	final verticalResult = parseResult(
		"A
		B
		C" );

	final diagonal = parseInput(
		"3
		AXX
		XBX
		XXC
		ABC" );

	final diagonalResult = parseResult(
		"A  
		 B 
		  C" );

	final theSimpsons = parseInput(
"10
IPLUCJMCNY
AAFIIVADZN
TFUUSWGHWE
UBARTAGDOG
YSAJIGIUGR
DTEMRFEOKA
HYTEBKZCHM
BOMAHARBAL
WOOQPUERNE
HEZUYIJHNS
Abraham Bart Homer Lisa Maggie Marge Patty Selma" );

	final theSimpsonsResult = parseResult(
"  L   M   
   I  A   
    S G  E
 BARTAG  G
Y     I  R
 T  R E  A
  TE     M
  MAHARBAL
 O  P    E
H        S" );

	final famousAnimals = parseInput(
"15
KOKODPEOTOTULCI
QAEOXQGBPYZWEFB
RWLRDBBLMFBAVWM
DLTIUCSIBAESGLA
YWKAXAURQSRASAB
XXUEPCMPUARAYSO
GJURRSPOFFCHHSH
HRIQWMMQIOKOWII
ELUALYIEOTLABEQ
DGJMEKLTDEDPMUD
WAFKPDTILIKUMAN
IKCEZYHVWEHTCHH
GITCDZCYZEAQPPC
MAUNGPJAKQCEMOC
BLZRPXBLTKPMASJ
April Balto Bambi Dolly Garfield GrumpyCat Ham Harambe Hedwig Jaws Kermit Koko Laika Lassie MickeyMouse Seabiscuit Tilikum Toto" );

	final famousAnimalsResult = parseResult(
"KOKOD EOTOT   I
   O   B      B
  L     M     M
 LTIUCSIBAESGLA
Y K  A   SRA AB
   EP   U RA S 
G  RRS O F  HS 
HRI WMM I    I 
ELUA YIEOTLABE 
D JME LT    M  
WA KPDTILIKUMA 
IKC  Y        H
GI    C        
MA     A       
 L      T      " );

	final usPresidents = parseInput(
"15
YYGNTTCHRELYTSE
BCDAIAPMONROEMG
YUFERXGIIOWLSAD
UTCTNROUETVGADI
XOEHANLNERSEJAL
CRDNALEVELCORRO
ZKTAANNKBFHEUGO
BIDENOANUNWHNAC
HAYESOONSOTOLRJ
FYXIRSTOHRPBOFA
QODDISNNAXOACIC
YARRFXEMIFLMNEK
MFRDUSMMCLKAILS
JAGNIDRAHNCYLDO
HQREPZFILLMOREN
Adams Arthur Biden Buchanan Bush Carter Cleveland Clinton Coolidge Eisenhower Fillmore Ford Garfield Grant Harding Harrison Hayes Hoover Jackson Johnson Kennedy Lincoln Madison Monroe Nixon Obama Pierce Polk Taft Tyler" );

	final usPresidentsResult = parseResult(
" Y NT CHRELYTSE
B DAIAPMONROEMG
 UFERXGI O   AD
 TCTNRO E V  DI
  EHAN N R EJAL
 RDNALEVELCORRO
  T  NNKB HEUGO
BIDENOANUNWHNAC
HAYESOONSOTOLRJ
F  I STOHRPBOFA
 OD I NNA OACIC
 ARR  E I LMNEK
M RD S   LKAILS
 AGNIDRAH C LDO
H  E  FILLMOREN" );

	final populousCountries = parseInput(
"15
BANGLADESHJULMS
SCRQJRTTGSNJIEE
PIHAAPUEUIHUZXN
AEPIYRRSTRGBAII
IACGNMIESAKPRCP
NDENAADANIZEBOP
WAZNASIDPTASYMI
NNYITRAIPOIHTEL
OAUAECFVIETNAMI
ICTGAISENODNIYH
TEISZLUYDKGYRLP
SNVDIPRXIPEHAAO
NADUSKGCAZXNNTZ
MDNALIAHTFQBYIT
MYANMARPOLANDAK
Bangladesh Brazil Canada China Egypt Ethiopia France Germany India Indonesia Iran Iraq Italy Japan Kenya Mexico Myanmar Nigeria Pakistan Philippines Poland Russia Spain Sudan Thailand Turkey Uganda UnitedStates Vietnam" );

	final populousCountriesResult = parseResult(
"BANGLADESH ULMS
SC QJRTTG N IEE
P HAAPUEUI UZXN
AEPIYRRSTRG AII
IACGNMIESAK RCP
NDENAADANI EBOP
 A NASID  A Y I
NNY TRAIPOIHTEL
 A AE FVIETNAMI
 CTGAISENODNIYH
 EIS    DK  RLP
SN  I   I E AA 
NADUSK  A  NNT 
 DNALIAHT   YI 
MYANMARPOLANDA " );

	final manyPeopleWithOneName = parseInput(
"15
MCVEJBRJEOSLHKD
IWOHCWBLXUAAYKD
NLPNDATZMPLZDSS
ATXZFORAZSREMOH
VPDATUDETQQICIZ
OMSSHACOBAKRNVO
TZIRRRNICIALXCR
NRRTEUYQUTLRPXE
AOSPLATOESMLGBE
MOGMNLOSSPXXURL
NBAVICIIEUZXDMV
ERIATLOVLRDFHII
OJEXJETPECDWHUS
RSRAZWYLNNYUAYX
BBKKSBFTAEZNZNL
Aristotle Avicii Confucius Elvis Halston Homer Liberace Mantovani Nostradamus Plato Prince Selena Socrates Voltaire" );

	final manyPeopleWithOneNameResult = parseResult(
" C E    E S H  
I O C  L U A   
N  N AT MPL   S
A   FORA SREMOH
V   TUDET  IC  
O  S ACOB  RN  
T I R NI IA  C 
NR T    UTL   E
A SPLATOES    E
MO     SS     L
N AVICIIE     V
ERIATLOVL     I
        E     S
        N      
        A      " );

	final olderCountries = parseInput(
"30
OXXXHDPMELPAMYUHKTDQTKPGFSDSME
QQMXNTWRIJLOGSAXASPITLORFLILCA
VJUABGOTGHDHVKIKPAFUIGAWMOZOHP
YWLALPHBTGAIHRBFHSUNENNEHVUVAV
KOBSAUAVNERMKWRSGULICRTCUAOENC
PFVGARYIJGOXWBEIARDESCTHYKCNNU
RANNBAKBIYIPTRSHEAHRESTONIAIEP
MIIAWDVNGNOKGNOHRLDSDMMMRAOALA
SADREJIKRAMNEDNMOENDFMEKIIJHIT
XOOTNSLUXEMBOURGKBGREECECXCMSL
SNIALEJBOSNIAANDHERZEGOVINAOLA
INTARADJBSQYTOSHTAADANACDZRIAM
ULNUPUNEQUAWFWGQUYJQKNGDUANZNN
NDFAVGBOWINAILIMOLATVIAZEBBLDU
SINCXXUATSYTUGHTSQDNALIAHTAASJ
TTANKULARKZUQSSYAIRAGLUBNKUGMH
CNNPCZOWDEIETYTDFLPSUAZCEORUAU
FIJOSRTTREZHNZVRNJYKDNALNIFTRN
EJLDCZULGZLAMGLGIARIEXGHQULRTG
VTKBUHABFEHOMGKRWALXWYFEFDSOIA
EQPZUNUYXUXJUVHIITKRLTZOJBXPNR
OAXADPNKOPMTZPFNYAMDETPAJVYNIY
EAPYVAEROMANIAEGDIUKIHRWKMOEQZ
XXHNMOCREIFIXQJUEWIFRMTMLIHXUY
MMYRBFAPHNWSSQZBHAGTYGPEGSUDER
WXEISBZCRCORBSWQNNLQKKIGNAOTAW
NGHTCOPQAMERNHUDNMEDPTSXGJTBXJ
LZBMQJPWHRVZQLCRSDBDCWFSBXIMHG
ZDVKLMAIYGUPCAHKGPBRBPCUBHAJCX
JGGWCCGTEWWCLHSEBWBIVFRYHICXHI
Aruba Austria Barbados Belarus Belgium BosniaAndHerzegovina Bulgaria Canada ChannelIslands Croatia Cuba Curacao CzechRepublic Denmark Estonia Finland France Germany Greece Guadeloupe HongKong Hungary Italy Japan Latvia Lithuania Luxembourg Malta Martinique Netherlands Norway Poland Portugal PuertoRico Romania Russia Serbia Singapore Slovakia Slovenia SouthKorea Spain Sweden Switzerland Taiwan Thailand Ukraine UnitedKingdom USVirginIslands" );

	final olderCountriesResult = parseResult(
"     D  EL  M U         FS S  
    N  RI  O SA   P    R L LC 
   A  OT  D V I    U  A  O OH 
  L  PHB G I  B  S  EN   V VA 
 O  AUA N R   R  U  CR   A EN 
P  GARYI G    E AR E  T  K NN 
  NNBAK I     S EA  ESTONIAIE 
 IIAWD NGNOKGNOHRL      RA ALA
SADRE IKRAMNED  OE       I  IT
 OOTNSLUXEMBOURGKBGREECE  C SL
SNIALEJBOSNIAANDHERZEGOVINAOLA
 N ARAD       S T ADANAC    AM
U N PU E  A  W  U       U   N 
ND A GB WI AI I OLATVIA  B LD 
SIN   UATS TU  TS DNALIAHTAAS 
  A    A  Z  SS AIRAGLUB   GMH
C  P  O DE    TD L  U      UAU
 I  SR  RE     RN YKDNALNIFTRN
  L C  L  L     IAR        RTG
   B  A    O     AL        OIA
    UN Y    U   IT R       PNR
    DPN      P N AM E       IY
     AEROMANIAE  IU  H      Q 
    MO R   I     WI   T     U 
   R  A H   S    AG    E    E 
  E    C C   S   NL     N     
 G      A E   U   E           
         R Z   R  B           
          U C                 
           C                  " );
}
