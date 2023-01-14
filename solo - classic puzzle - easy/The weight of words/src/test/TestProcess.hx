package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", {
				final ip = test1;
				Main.process( ip.steps, ip.w, ip.h, ip.grid ).should.be( test1Result ); });
			it( "Test2", {
				final ip = test2;
				Main.process( ip.steps, ip.w, ip.h, ip.grid ).should.be( test2Result ); });
			it( "Test3", {
				final ip = test3;
				Main.process( ip.steps, ip.w, ip.h, ip.grid ).should.be( test3Result ); });
			it( "Test4", {
				final ip = test4;
				Main.process( ip.steps, ip.w, ip.h, ip.grid ).should.be( test4Result ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final steps = parseInt( lines[0] );
		final h = parseInt( lines[1] );
		final w = parseInt( lines[2] );
		var grid = [for( i in 0...h ) lines[i + 3].split( "" )];
	
		return { steps: steps, w: w, h: h, grid: grid };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"3
	2
	4
	YDOS
	CEAE" );
	
	final test1Result = parseResult(
	"EASY
	CODE" );
	
	final test2 = parseInput(
	"19
	7
	8
	NAGRUGIE
	EDSENNTW
	SKTDEIDR
	RDSHMLAA
	CHOLNBOF
	EOFNLLTT
	SEEHACLE" );
	
	final test2Result = parseResult(
	"THEMANIN
	BLACKFLE
	DACROSST
	HEDESERT
	ANDTHEGU
	NSLINGER
	FOLLOWED" );
	
	final test3 = parseInput(
	"7
	16
	20
	DCOLNTNTSLTPTNTDLIAO
	ONSGOIOSLSCAWIKRRNAN
	HHYRDMTDIIIWORENTONT
	AFLYRNNHPHLEHGEMOEKG
	LNNWATOETVHSNESFEELD
	ISANAHRORRITHUEDESTR
	TINHDIOOHAEDTSWUAEFM
	MHYNWTAOEGLCATAGTLEA
	ESADLTONEEIWYTTIAINR
	ASHBEEAGIDCSTHTSLIRO
	TAGAEENTTNGIIHHCHHLO
	YMGHHTADLNMHFETHHSAT
	NWIOHSNNFLNACOMGLAHD
	EDIHEDONEETWROLSNETM
	AWSRMELDLALHLSHSHGAL
	SIADIMERAINTHAWAHIIN" );
	
	final test3Result = parseResult(
	"NIGHTGATHERSANDNOWMY
	WATCHBEGINSITSHALLNO
	TENDUNTILMYDEATHISHA
	LLTAKENOWIFEHOLDNOLA
	NDSFATHERNOCHILDRENI
	SHALLWEARNOCROWNSAND
	WINNOGLORYISHALLLIVE
	ANDDIEATMYPOSTIAMTHE
	SWORDINTHEDARKNESSIA
	MTHEWATCHERONTHEWALL
	SIAMTHESHIELDTHATGUA
	RDSTHEREALMSOFMENIPL
	EDGEMYLIFEANDHONORTO
	THENIGHTSWATCHFORTHI
	SNIGHTANDALLTHENIGHT
	STOCOMENIGHTGATHERSA" );
	
	final test4 = parseInput(
	"5000
	16
	18
	MOETYSEEURBKNEAOET
	ONTESFDWEWIRAIOONG
	RIRWIISRSOLIORNEEE
	ENSHSOIRMRPTOPDEDE
	RMHHEDKLUOTDDNGHOW
	TEIUEUHOOINSTRHPHC
	MPLWLEDTSKTAONRRTO
	IYNKLRBASIEDRDETDN
	KMNENMERNHESAHLRFE
	OEHALNRDNSLGOSIODD
	RWNTCITEENEOBEHBCD
	VDANATTEMSNAEVEORG
	GTEAAEAUDIHMHPTSRN
	AEPENTHTEEDREOREDS
	NAWORGOEBGEIADEAEL
	DNTNNRWEENSREDGIAN" );
	
	final test4Result = parseResult(
	"DEEPINTOTHATDARKNE
	SSPEERINGLONGISTOO
	DTHEREWONDERINGFEA
	RINGDOUBTINGDREAMI
	NGDREAMSNOMORTALSE
	VERDAREDTODREAMBEF
	OREBUTTHESILENCEWA
	SUNBROKENANDTHESTI
	LLNESSGAVENOTOKENA
	NDTHEONLYWORDTHERE
	SPOKENWASTHEWHISPE
	REDWORDLENORETHISI
	WHISPEREDANDANECHO
	MURMUREDBACKTHEWOR
	DLENOREMERELYTHISA
	NDNOTHINGMOREDEEPI" );
}
