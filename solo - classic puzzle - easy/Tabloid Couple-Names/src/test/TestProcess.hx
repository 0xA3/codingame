package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Single", { Main.process( single ).should.be( singleResult ); });
			it( "Classics", { Main.process( classics ).should.be( classicsResult ); });
			it( "You have options", { Main.process( youHaveOptions ).should.be( youHaveOptionsResult ); });
			it( "Lots of Options", { Main.process( lotsOfOptions ).should.be( lotsOfOptionsResult ); });
			it( "Is that really your person", { Main.process( isThatReallyYourPerson ).should.be( isThatReallyYourPersonResult ); });
			it( "Fun Couples", { Main.process( funCouples ).should.be( funCouplesResult ); });
			it( "Test 6", { Main.process( test6 ).should.be( test6Result ); });
			it( "Test 7", { Main.process( test7 ).should.be( test7Result ); });
			it( "Test 8", { Main.process( test8 ).should.be( test8Result ); });
			it( "Test 9", { Main.process( test9 ).should.be( test9Result ); });
			it( "Three-Overlap-Letters", { Main.process( threeOverlapLetters ).should.be( threeOverlapLettersResult ); });
			it( "Test 11", { Main.process( test11 ).should.be( test11Result ); });
			it( "Test 12", { Main.process( test12 ).should.be( test12Result ); });
			it( "Test 13", { Main.process( test13 ).should.be( test13Result ); });
			it( "Carrie Bradshaw Plus 1", { Main.process( carrieBradshawPlus1 ).should.be( carrieBradshawPlus1Result ); });
			it( "Test 15", { Main.process( test15 ).should.be( test15Result ); });
			it( "Test 16", { Main.process( test16 ).should.be( test16Result ); });
			it( "Test 17", { Main.process( test17 ).should.be( test17Result ); });
			it( "So many options", { Main.process( soManyOptions ).should.be( soManyOptionsResult ); });
			it( "Test 19", { Main.process( test19 ).should.be( test19Result ); });
			it( "Musical", { Main.process( musical ).should.be( musicalResult ); });
			it( "Scandalous", { Main.process( scandalous ).should.be( scandalousResult ); });
			it( "OITNB and L-Word", { Main.process( oitnbAndLWord ).should.be( oitnbAndLWordResult ); });
			it( "So much overlap", { Main.process( soMuchOverlap ).should.be( soMuchOverlapResult ); });
			it( "I am not Us", { Main.process( iAmNotUs ).should.be( iAmNotUsResult ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return lines.slice( 1 );
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final single = parseInput(
		"1
		Fred and Ethel Mertz" );

	final singleResult = parseResult(
		"Fred plus Ethel = Ethed Frel Frethel" );

	final classics = parseInput(
		"6
		Lois and Clark
		Ben and Jennifer
		Tarzan and Jane
		Priscilla and Elvis
		Simba and Nala
		Mork and Mindy" );
	
	final classicsResult = parseResult(
		"Lois plus Clark = Clois
		Ben plus Jennifer = Bennifer
		Tarzan plus Jane = Tarzane
		Priscilla plus Elvis = Elviscilla
		Simba plus Nala = Simbala
		Mork plus Mindy = NONE" );
	
	final youHaveOptions = parseInput(
		"6
		Brad and Angelina
		Zac and Vanessa
		Cory and Topanga from Boy Meets World
		Harry and Markle of Montecito
		Frida and Diego as in Frida Kahlo and Diego Rivera
		Cam and Mitchell on Modern Family" );
	
	final youHaveOptionsResult = parseResult(
		"Brad plus Angelina = Angelinad Brangelina
		Zac plus Vanessa = Vac Vanessac Zanessa
		Cory plus Topanga = Copanga Tory
		Harry plus Markle = Harkle Marry
		Frida plus Diego = Fridiego Friego
		Cam plus Mitchell = Camitchell Mitcam" );
		

	final lotsOfOptions = parseInput(
		"4
		Heidi and Spencer as in Heidi Montag and Spencer Pratt from The Hills
		Chandler and Monica on Friends
		John and Yoko as in John Lennon and Yoko Ono
		Miley and Liam as in Flowers" );
	
	final lotsOfOptionsResult = parseResult(
		"Heidi plus Spencer = Hencer Speidi Spenceidi
		Chandler plus Monica = Chanica Mondler Monicandler Monichandler
		John plus Yoko = Joko Yohn Yokohn
		Miley plus Liam = Liamiley Liley Miam Miliam" );

	final isThatReallyYourPerson = parseInput(
		"5
		Ross and Rachel on Friends
		Baby and Johnny from Dirty Dancing
		Ennis and Jack from Brokeback Mountain
		George and Amal as in George Clooney and Amal Clooney
		Zach and Kelly in Saved By The Bell" );
	
	final isThatReallyYourPersonResult = parseResult(
		"Ross plus Rachel = NONE
		Baby plus Johnny = NONE
		Ennis plus Jack = NONE
		George plus Amal = NONE
		Zach plus Kelly = NONE" );
	
	final funCouples = parseInput(
		"15
		Edward and Wallis as in Prince Edward and Wallis Simpson
		Fred and Ethel Mertz
		Jack and Marilyn as in JFK and Miss Marilyn Monroe
		JayZ and Beyonce -- musical royalty
		Lady and Tramp -- from Lady and the Tramp
		Richard and Pat Nixon
		Luke and Lorelai from The Gilmore Girls
		Mickey and Minnie -- The Mouses
		Kermit and Piggy -- as in Miss Piggy from The Muppet Show
		Bill and Hillary Clinton
		Ralph and Alice (The Honeymooners)
		Bert and Ernie from Sesame Street
		Pete and Chasten Buttigieg
		Nico and Bethany as in Nico Tortorella and Bethany Meyers
		Carl and Dolly Parton" );
	
	final funCouplesResult = parseResult(
		"Edward plus Wallis = Edwallis
		Fred plus Ethel = Ethed Frel Frethel
		Jack plus Marilyn = Jarilyn Mack
		JayZ plus Beyonce = Beyz Jayonce
		Lady plus Tramp = Lamp Trady
		Richard plus Pat = Pard Richat
		Luke plus Lorelai = Loreluke Lukelai
		Mickey plus Minnie = Minnickey Minniey
		Kermit plus Piggy = Kermiggy
		Bill plus Hillary = Billary
		Ralph plus Alice = Ralice
		Bert plus Ernie = Bernie
		Pete plus Chasten = Peten
		Nico plus Bethany = Bethanico
		Carl plus Dolly = Carlly Carly" );
	
	final test6 = parseInput(
		"7
		Abe and Mary Lincoln
		Aladdin and Jasmine from Aladdin
		Ashton and Mila as in Ashton Kutcher and Mila Kunis
		Barney and Betty Rubble -- the Flintstones' neighbors
		Belle and Beast from Beauty and the Beast
		Bonnie and Clyde (outlaws)                                         
		Heathcliff and Clair Huxtable of The Cosby Show" );
	
	final test6Result = parseResult(
		"Abe plus Mary = Mabe
		Aladdin plus Jasmine = Aladdine
		Ashton plus Mila = Milashton
		Barney plus Betty = Barnetty
		Belle plus Beast = Belleast
		Bonnie plus Clyde = NONE
		Heathcliff plus Clair = Heathclair" );
	
	final test7 = parseInput(
		"7
		Ilsa and Rick from Casablanca
		Ward and June Cleaver
		Hyde and Donna on That 70s Show
		Sally and Jack Skellington in The Nightmare Before Christmas
		Mario and Peach -- as in Mario and Princess Peach (Nintendo)
		Lovey and Thurston Howell
		Shrek and Fiona" );
	
	final test7Result = parseResult(
		"Ilsa plus Rick = Rilsa
		Ward plus June = NONE
		Hyde plus Donna = Hydonna
		Sally plus Jack = Jally Sack
		Mario plus Peach = Peario
		Lovey plus Thurston = Thurstovey
		Shrek plus Fiona = NONE" );
	
	final test8 = parseInput(
		"5
		George and Martha Washington, the first US President and First Lady
		Slim and Steve
		Tom and Rita as in Tom Hanks and Rita Wilson
		Phil and Marlo as in Phil Donahue and Marlo Thomas
		Cosmo and Wanda from The Fairly Odd Parents" );
	
	final test8Result = parseResult(
		"George plus Martha = Geortha
		Slim plus Steve = NONE
		Tom plus Rita = Ritom
		Phil plus Marlo = Philo
		Cosmo plus Wanda = NONE" );
	
	final test9 = parseInput(
		"5
		Fred and Ginger as in Astaire and Rogers
		Mildred and Richard Loving (pioneers)
		Sheldon and Amy of The Big Bang Theory
		Pierre and Marie Curie (scientists)
		Red and Kitty on That 70s Show " );
	
	final test9Result = parseResult(
		"Fred plus Ginger = Frer Ginged Gingered
		Mildred plus Richard = Michard Mildrichard Richardred Richared Rildred
		Sheldon plus Amy = NONE
		Pierre plus Marie = Marierre
		Red plus Kitty = NONE" );
	
	final threeOverlapLetters = parseInput(
		"5
		Hillary and William Clinton
		Meredith and Derek (Grey's Anatomy)
		Santana and Brittany (Glee)
		Elliot and Shelley Duvall (Fake)
		Apple and Plex (entertainment couple)" );
	
	final threeOverlapLettersResult = parseResult(
		"Hillary plus William = Hilliam Willary
		Meredith plus Derek = Deredith Merek
		Santana plus Brittany = Brittana Santany
		Elliot plus Shelley = Shelliot
		Apple plus Plex = Applex" );
	
	final test11 = parseInput(
		"7
		Amber and Elon
		Phoebe and Joey from Friends
		Charles and Diana
		Liz and Dick (Elizabeth Taylor and Richard Burton)
		Fang and Joan Rivers
		Tony and Maria (West Side Story)
		Vivian and Edward (Pretty Woman)" );
	
	final test11Result = parseResult(
		"Amber plus Elon = Ambelon
		Phoebe plus Joey = Joebe Phoey
		Charles plus Diana = Chana Dianarles Diarles
		Liz plus Dick = Diz Lick
		Fang plus Joan = Joang
		Tony plus Maria = NONE
		Vivian plus Edward = Viviard" );
	
	final test12 = parseInput(
		"8
		Neo and Trinity (The Matrix)
		Sandy and Danny (Grease)
		Katniss and Peeta (Hunger Games)
		Edward and Bella (Twilight)
		Stella and Winston (How Stella Got Her Groove Back)
		Latika and Jamal (Slumdog Millionaire)
		Allie and Noah (The Notebook)
		Lisa and Patrick Swayze" );
	
	final test12Result = parseResult(
		"Neo plus Trinity = Trineo
		Sandy plus Danny = Dandy Sanny
		Katniss plus Peeta = Peetatniss Peetniss
		Edward plus Bella = Bedward Bellard
		Stella plus Winston = Winstella
		Latika plus Jamal = Jamalatika Jamatika Jatika Lamal Latikal Latikamal
		Allie plus Noah = Noallie
		Lisa plus Patrick = Lick Lisatrick Patrisa" );
	
	final test13 = parseInput(
		"7
		Pamela and Tommy as in Pamela Anderson and Mötley Crüe drummer Tommy Lee
		Jack and Jill from Up The Hill
		Mother and Mike Pence
		Vivien and Laurence as in Vivien Leigh and Laurence Olivier
		Jennifer and Harry Styles
		Angela and Jordan (My So Called Life)  
		Florida and James Evans in Good Times  " );
	
	final test13Result = parseResult(
		"Pamela plus Tommy = Pammy Tomela Tommela
		Jack plus Jill = NONE
		Mother plus Mike = Miker
		Vivien plus Laurence = Vivience
		Jennifer plus Harry = Jenniferry Jennifery
		Angela plus Jordan = Jordangela
		Florida plus James = Floridames" );
	
	final carrieBradshawPlus1 = parseInput(
		"9
		Carrie and Jake
		Carrie and Big (Mr. Big)
		Carrie and Aidan Shaw
		Carrie and Vaughn Wysel
		Carrie and Jack Berger
		Carrie and Ben
		Carrie and Sam
		Carrie and Ray
		Carrie and Joe" );
	
	final carrieBradshawPlus1Result = parseResult(
		"Carrie plus Jake = Cake Jarrie
		Carrie plus Big = Bie Carrig
		Carrie plus Aidan = Aidarrie Caidan Carridan
		Carrie plus Vaughn = Caughn Varrie
		Carrie plus Jack = Cack Jacarrie Jarrie
		Carrie plus Ben = Carrien
		Carrie plus Sam = Cam Sarrie
		Carrie plus Ray = Caray Carray Cay Rarrie
		Carrie plus Joe = NONE" );
	
	final test15 = parseInput(
		"10
		Fitz and Olivia Pope, Scandal
		Jesse and Becky in Full House
		Ben and Leslie (Parks and Recreation)
		Angel and Buffy The Vampire Slayer
		Mindy and Danny (The Mindy Project)
		Fonzie and Pinky Tuscadero on Happy Days
		Tony and Carmela Soprano
		Callie and Arizona in Grey’s Anatomy
		Joanie and Chachi on Happy Days
		Mia and Vincent Vega in Pulp Fiction" );
	
	final test15Result = parseResult(
		"Fitz plus Olivia = Fivia Olitz Olivitz
		Jesse plus Becky = Besse Jecky Jessecky
		Ben plus Leslie = Beslie Len Leslien
		Angel plus Buffy = NONE
		Mindy plus Danny = Dandy Danndy Mindanny Minny
		Fonzie plus Pinky = Fonky Fonzinky Pinzie
		Tony plus Carmela = NONE
		Callie plus Arizona = Arizonallie Callizona Carizona
		Joanie plus Chachi = Chachie Chanie Joachi
		Mia plus Vincent = Mincent Via" );
	
	final test16 = parseInput(
		"9
		Fran and Maxwell (as in Maxwell Sheffield and The Nanny Fran Fine)
		Kevin and Winnie of The Wonder Years
		Logan and Veronica Mars
		Kennedy and Willow in Buffy The Vampire Slayer
		Marshall and Lily in How I Met Your Mother  
		Paul and Jamie (Mad About You)
		Blaine and Kurt in Glee
		Doug and Carol in ER
		James and Mary as in Carville and Mary Matalin" );
	
	final test16Result = parseResult(
		"Fran plus Maxwell = Fraxwell
		Kevin plus Winnie = Kevinnie
		Logan plus Veronica = Loganica Lonica Verogan Veronican
		Kennedy plus Willow = NONE
		Marshall plus Lily = Lill Marshalily Marshallily Marshally Marshaly
		Paul plus Jamie = Jaul Pamie
		Blaine plus Kurt = NONE
		Doug plus Carol = Caroug
		James plus Mary = Jamary Jary Mames" );
	
	final test17 = parseInput(
		"8
		Cookie and Luscious Lyon, Empire
		David and Maddie (Moonlighting)
		Aria and Ezra (Pretty Little Liars)
		Edith and Archie in All In The Family
		Felicity and Ben (Felicity)
		Seth and Summer of The O.C.
		Sydney and Vaughn (Alias)
		David and Patrick in Schitt’s Creek" );
	
	final test17Result = parseResult(
		"Cookie plus Luscious = Cookious Luscie Lusciokie Lusciookie Luscookie
		David plus Maddie = Daddie Daviddie Davidie Davie Madavid Maddavid Maddid Mavid
		Aria plus Ezra = Ezraria Ezria
		Edith plus Archie = Archiedith Archith Edithie
		Felicity plus Ben = Belicity Fen
		Seth plus Summer = Summeth
		Sydney plus Vaughn = Vaughney
		David plus Patrick = Datrick Davick Patrid Pavid" );
	
	final soManyOptions = parseInput(
		"2
		Poussey and Soso (Orange Is The New Black)  
		Veronica and Kevin (Shameless)" );
	
	final soManyOptionsResult = parseResult(
		"Poussey plus Soso = Poso Pouso Pousoso Pousso Poussoso Sosey Sosoussey Sossey Soussey
		Veronica plus Kevin = Keronica Keveronica Kevica Kevinica Veronin Vevin" );
	
	final test19 = parseInput(
		"6
		Enrique and Jennifer as in the Enrique Iglesias & Jennifer Lopez Tour
		Trista and Ryan Sutter on the first Bachelorette
		Xana and Ethan
		Elizabeth and Philip -- as in Queen Elizabeth and Prince Philip
		Isadora and Paris as in Isadora Duncan and Paris Singer
		Lilly and Simon locally famous dogs" );
	
	final test19Result = parseResult(
		"Enrique plus Jennifer = Jenrique
		Trista plus Ryan = Tristan Tryan
		Xana plus Ethan = Ethana
		Elizabeth plus Philip = Philizabeth
		Isadora plus Paris = Parisadora
		Lilly plus Simon = Limon Silly" );
	
	final musical = parseInput(
		"15
		Kurt and Courtney as in Kurt Cobain of Nirvana and Courtney Love of Hole
		Rihanna and Chris Brown
		Miranda and Blake as in Miranda Lambert and Blake Shelton
		Garth and Trisha as in Garth Brooks and Trisha Yearwood
		Ike and Tina Turner
		Selena and Justin as in Selena Gomez and Justin Bieber
		Nick and Jessica as in Nick Lachey and Jessica Simpson
		Carly and James as in Carly Simon and James Taylor
		Sony and Cher
		Madonna and Vanilla as in Madonna and Vanilla Ice
		Gloria and Emilio Estefan (Miami Sound Machine)
		Camilla and Shawn as in Camilla Cabello & Shawn Mendes
		Tim and Faith as in Tim McGraw and Faith Hill
		George and Tammy as in George Jones and Tammy Wynette
		Avril and Chad as in Avril Lavigne & Chad Kroeger of Nickelback" );
	
	final musicalResult = parseResult(
		"Kurt plus Courtney = Kurtney
		Rihanna plus Chris = Chrihanna
		Miranda plus Blake = Blanda Mirake Mirandake
		Garth plus Trisha = Garisha Gartha Gartrisha Trisharth
		Ike plus Tina = Tike
		Selena plus Justin = Juselena Justina
		Nick plus Jessica = Jessick Nica
		Carly plus James = Cames Jarly
		Sony plus Cher = NONE
		Madonna plus Vanilla = Madonilla Madonnanilla Madonnilla Manilla Vadonna Vanilladonna
		Gloria plus Emilio = Emilia Emilioria Emiloria Glorilio Glorio
		Camilla plus Shawn = Camillawn Shamilla
		Tim plus Faith = Faim Faitim Tith
		George plus Tammy = NONE
		Avril plus Chad = Chavril" );
	
	final scandalous = parseInput(
		"10
		David and Rebecca as in David Beckham and Rebecca Loos
		Elizabeth and Eddie as in Elizabeth Taylor and Eddie Fisher
		Frank and Ava as in Sinatra and Gardner
		Frank and Mia as in Sinatra and Farrow
		Woody and Mia as in Woody Allen and Mia Farrow
		Jude and Sienna as in Jude Law and Sienna Miller
		Arnold and Maria as in Arnold Schwarzenegger and Maria Shriver
		Elin and Tiger as in Elin Nordegren and Tiger Woods
		David and Regina as in David Letterman and Regina Lasko
		Bryan and Kaylee in deranged fantasy-land" );
	
	final scandalousResult = parseResult(
		"David plus Rebecca = Rebeccavid
		Elizabeth plus Eddie = Eddielizabeth Eddieth Eddizabeth Elizabeddie
		Frank plus Ava = Avank Frava
		Frank plus Mia = Miank
		Woody plus Mia = NONE
		Jude plus Sienna = Judenna
		Arnold plus Maria = Marnold
		Elin plus Tiger = Eliger Tigelin
		David plus Regina = Davina Regid Reginavid
		Bryan plus Kaylee = Bryaylee Brylee Kayan" );
	
	final oitnbAndLWord = parseInput(
		"13
		Nicky and Lorna in OITNB
		Alex and Piper in OITNB
		Bette and Tina
		Gigi and Dani
		Alice and Tasha
		Alice and Dana
		Bette and Pippa
		Sophie and Finley
		Shane and Tess
		Carmen and Jenny Schecter
		Jenny and Niki as in Jenny Schecter and Niki Stevens
		Shane and Carmen
		Micah and Jose" );
	
	final oitnbAndLWordResult = parseResult(
		"Nicky plus Lorna = Lornicky
		Alex plus Piper = Aler Pipex
		Bette plus Tina = Betina Bettina
		Gigi plus Dani = Danigi
		Alice plus Tasha = Talice Tashalice
		Alice plus Dana = Dalice Danalice
		Bette plus Pippa = NONE
		Sophie plus Finley = Sophiey Sophinley
		Shane plus Tess = Shaness Teshane Tesshane
		Carmen plus Jenny = Carmenny
		Jenny plus Niki = Jeniki Jenniki
		Shane plus Carmen = Carmene Shanen Sharmen
		Micah plus Jose = NONE" );
	
	final soMuchOverlap = parseInput(
		"7
		BoyAbba and ABBAGirl to show 4 overlapping letters and different capitalization
		Xperson and PersonY to show 6 overlapping letters and different capitalization
		Hollywood and Woody to show 4 overlapping letters
		Alex and Alexa McFake (only one overlapping letter)
		Count and Countess
		Norma and Normaxi vonFake
		Leo and Aleo O'Madeup " );
	
	final soMuchOverlapResult = parseResult(
		"BoyAbba plus ABBAGirl = Boyabbagirl
		Xperson plus PersonY = Xpersony
		Hollywood plus Woody = Hollywoody
		Alex plus Alexa = Alexalex
		Count plus Countess = NONE
		Norma plus Normaxi = NONE
		Leo plus Aleo = NONE" );
	
	final iAmNotUs = parseInput(
		"2
		Charles and Charlotte as in Charles Leclerc and Charlotte Sine
		Sandy and Sammy (Pentacostal YouTubers Sandy Asare and Sammy Baah)" );
	
	final iAmNotUsResult = parseResult(
		"Charles plus Charlotte = Charlottes
		Sandy plus Sammy = NONE" );
}
