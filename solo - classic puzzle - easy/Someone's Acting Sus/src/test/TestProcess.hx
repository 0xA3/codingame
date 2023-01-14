package test;

import Main.getDistance;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getDistance", {
			it( "AB", {
				getDistance( "A", "B", 2, "AB" ).should.be( 1 );
			});
			it( "BA", {
				getDistance( "B", "A", 2, "AB" ).should.be( 1 );
			});
			it( "AC", {
				getDistance( "A", "C", 5, "ABCDE" ).should.be( 2 );
			});
			it( "CA", {
				getDistance( "C", "A", 5, "ABCDE" ).should.be( 2 );
			});
			it( "EA", {
				getDistance( "E", "A", 5, "ABCDE" ).should.be( 1 );
			});
			it( "AE", {
				getDistance( "A", "E", 5, "ABCDE" ).should.be( 1 );
			});
		});

		describe( "Test process", {
			it( "basic sus inspection", {
				final ip = basicSusInspection;
				Main.process( ip.length, ip.layout, ip.crewmates ).should.be( basicSusInspectionResult );
			});
			it( "Can you handle number signs?", {
				final ip = canYouHandleNumberSigns;
				Main.process( ip.length, ip.layout, ip.crewmates ).should.be( canYouHandleNumberSignsResult );
			});
			it( "Your hacks kinda broke :)", {
				final ip = yourHacksKindaBroke;
				Main.process( ip.length, ip.layout, ip.crewmates ).should.be( yourHacksKindaBrokeResult );
			});
			it( "The Big Data Test", {
				final ip = theBigDataTest;
				Main.process( ip.length, ip.layout, ip.crewmates ).should.be( theBigDataTestResult );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final l = parseInt( lines[0] );
		final f = lines[1];
		final inputs = lines[2].split(' ');
		final n = parseInt( inputs[0] );
		final k = parseInt( inputs[1] );
		final crewmates = [for( i in 3...lines.length ) lines[i]];
			
		return { length: l, layout: f, crewmates: crewmates };
	}
	
	static function parseResult( input:String ) return input.replace( "\t", "" ).replace( "\r", "" );

	final basicSusInspection = parseInput(
		"6
		ABCDEF
		5 3
		ABC
		AFE
		CDC
		DBC
		AAA"
	);

	final basicSusInspectionResult = parseResult(
		"NOT SUS
		NOT SUS
		NOT SUS
		SUS
		NOT SUS"
	);

	final canYouHandleNumberSigns = parseInput(
		"10
		QWERTYUIOP
		8 6
		Q#E#TR
		Q##I#U
		Q##Y#O
		I#II#P
		Q####Y
		W##Y#O
		O##TRE
		######"
	);

	final canYouHandleNumberSignsResult = parseResult(
		"NOT SUS
		NOT SUS
		SUS
		NOT SUS
		NOT SUS
		SUS
		SUS
		NOT SUS"
	 );
 
	 final yourHacksKindaBroke = parseInput(
		"9
		WEUHFNALP
		8 8
		####WW#L
		F##P####
		#######A
		A###EW#L
		#W#####N
		PE#####W
		N##E####
		L##L###U"
	);

	final yourHacksKindaBrokeResult = parseResult(
		"NOT SUS
		SUS
		NOT SUS
		NOT SUS
		NOT SUS
		SUS
		SUS
		NOT SUS"
	 );
 
	final theBigDataTest = parseInput(
		"21
		YHKLURWFBAXSENCJIGMOQ
		40 50
		SA##NJ#M###O##EA###JO##GIMQYHKWFLQINBFUHH####MC#CN
		#WF##XXWFWBUKF##LOGGMQ##I#J#SX###XF#RBF#R##W#YKHMY
		XR#HMCMNGM#YRWWR#L#FRXXBURWFRYGNXEJNCO#UY##MY#YUWS
		#YQYQOQOOQYHYHHYQO#YYQOQOQYQOMOQOQOQ#QQ#Q#M#GMGM#M
		##AA##S#S#####XA#XS##EN#S###JJI#IJ#J#NCNC#I##J#CJC
		E##X#J#NI###OQI##XSBBW##OQ#W#MN#QOO#O##MO##SI##B#N
		###QY##K###YH#Y#Y##HK####K#LKHH##HK##KH#H#KHY##OQY
		MGMGGM#OMGMGIGGMGMGMGIJIJJCJIGMOQO#YHKKKHHHYHYQOMM
		##Y#H#WBBAEC#F#FKUU#YYK####K###LW#RH#UQIMI#CXX#XNX
		#O#YQ##Q#H##H##L##YQ###OO##Q##MO##QO##Q#M#Q####OMO
		MO###Q##QO#O##Q#Y#YQ#M#I###ESE##CJIGI##OOQOM#GIGMG
		Y#HQ#YKUWWWK#YQY##RYR#OC#SA#CN#BAUY#H#LWR#AE#R#RHG
		#BAXSXAXSESSX#BAABAABABFWRULKLKLKKLKLULKHKLLULULUR
		#WHOHQ###EJGNS#R#LBRAENJ#NACMYYR##N#NMQYKLBN#QQM#R
		GMOMGIGMGIGIJCJ#JCNEE#ENNENENESSEENCNNENENESEES#SX
		WF#AXA#X#SX#XSXSESE####CJCNNE##N#JCNENEN#NCNCN##NE
		##OH#I#I#N####CJQUYGNX#J#W#NISIQ###S#J####W####XES
		OQQHYIM#QH##XN##A#W#FX#F#O#ISSS###CMOO##L#LK##RYKL
		WRU#LKLK#YQQOOQQYQOMMMOQOQYQQO#YHKLL#LUUUL#LLKLURW
		K#U#####U#UU#U#KHHH#YH#KL#LKH##K#Y###H#L##URWRULKL
		#####WF#F##U####HKHK##H###YQOQYH##U##LURW#W###F#RR
		#J##CJJIJ#J##IJ##M#G#GMOQ#####OOMOQ#MMMOQ##YY##HKH
		RRW#W#####KKLKH#LKHK##KKH#Q#QY#YH##H###QOMG#GM#I#G
		SWR#B##XF####H#G#Y##L###YU##XXECXBLH##H#R#AB#X#C#N
		CICC#E#SANBSN######YUU#UL####BFU#OC###RKYQIQ#Y#GYK
		X#BLKF#URK#K####EN#O##IQY#Y###LBLB#HQJO##GJO#KQHGE
		###RWFB##RW#W##BA#SE##S##X##SS#SEENN#S##A#AB#W##WW
		CE#OY#LOYKL###YUAFSC###LYQ##IGMG#YL#F#X##RHY###OLF
		AEIOLYMQQGEXRFFB#EFWUUBXWWBSJ#E#SFK#WRLUQ#QJEGHRYQ
		##Q#M#M##JI#CN##X#ESXSXA#B##AXS#E###XABF#WFBFBFB#B
		C#CNENCNESESSENEENC#CNCJIJCJIJ#J#JIJJCJCNESXSX#XSE
		JIGIGIGMOQOQY#YHYQYYHYQY#YQYQYHYQOMOQOQY##KL#HYH#L
		GMG#IJCC#IGIJ#CJ###JC#JC####OO#QY##QOQOO#YHKL#L##R
		#A#R#W#######QU###RKRRRL##AWBEI##UB###E##KHKLHR##F
		QIIJOOC#XSFUBECGQMOHWU#XJ#MMNMK#OCCIIQQISFUWBNNSIJ
		QUW#CSF#RBRH#JJ#G#YUU#GC#NG#K##LB#QQL##K#IEJ#QURLK
		RWFWRW#R#WFW#WR#RU###WWFWRWRWR##ULKHYQOQ##OQYY##YQ
		#G#####O#L##A###R#QIS##M#SISN##F###H###E#ECM#GE##I
		KLKLKKLKHKHYH##Q#QYHYQY#KLKLKKH#L#HK##L#RRULLU#WFB
		NNCJ#CNCC#E#N##I##JJCJIIGMOM#OQ#QOQYQYHK##LK#LUULK"
	);
		
	final theBigDataTestResult = parseResult(
		"SUS
		SUS
		SUS
		NOT SUS
		NOT SUS
		SUS
		NOT SUS
		NOT SUS
		SUS
		NOT SUS
		NOT SUS
		SUS
		NOT SUS
		SUS
		NOT SUS
		NOT SUS
		SUS
		SUS
		NOT SUS
		NOT SUS
		NOT SUS
		NOT SUS
		NOT SUS
		SUS
		SUS
		SUS
		NOT SUS
		SUS
		SUS
		NOT SUS
		NOT SUS
		NOT SUS
		NOT SUS
		SUS
		SUS
		SUS
		NOT SUS
		SUS
		NOT SUS
		NOT SUS"
	 );

}

