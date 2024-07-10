package test;

import CompileTime.readFile;
import Main.MovieDataset;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "2 Degrees of Kevin Bacon", {
				final ip = _2DegreesOfKevinBacon;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 2 );
			});
			it( "One Degree of Kevin Bacon", {
				final ip = oneDegreeOfKevinBacon;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 1 );
			});
			it( "3 Degrees of Kevin Bacon", {
				final ip = _3DegreesOfKevinBacon;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 3 );
			});
			it( "Kevin Bacon Himself?!", {
				final ip = kevinBaconHimself;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 0 );
			});
			it( "Going big!", {
				final ip = goingBig;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 6 );
			});
			it( "The Biggest", {
				final ip = theBiggest;
				Main.process( ip.actor, ip.movieDatasets ).should.be( 4 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
			
		final actor = lines[0];
		final n = parseInt( lines[1] );
		final movieDatasets:Array<MovieDataset> = [for( i in 0...n ) {
			final nameActors = lines[i + 2].split( ":" );
			final name = nameActors[0];
			final actors = nameActors[1].split( "," ).map( s -> s.trim());
			
			final movieDataset:MovieDataset = {
				name: name,
				actors: actors
			}
	
			movieDataset;
		}];

		return { actor:actor, movieDatasets:movieDatasets };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final _2DegreesOfKevinBacon = parseInput(
		"Elvis Presley
		3
		Change of Habit: Elvis Presley, Mary Tyler Moore, Barbara McNair, Jane Elliot, Ed Asner
		JFK: Kevin Costner, Kevin Bacon, Tommy Lee Jones, Laurie Metcalf, Gary Oldman, Ed Asner
		Sleepers: Kevin Bacon, Jason Patric, Brad Pitt, Robert De Niro, Dustin Hoffman"
	);

	final oneDegreeOfKevinBacon = parseInput(
		"Brad Pitt
		3
		Tremors: Kevin Bacon, Fred Ward, Finn Carter, Michael Gross
		Sleepers: Kevin Bacon, Jason Patric, Brad Pitt, Robert De Niro, Dustin Hoffman
		Hollow Man: Kevin Bacon, Elisabeth Shue, Josh Brolin, Kim Dickens"
	);

	final _3DegreesOfKevinBacon = parseInput(
		"Shane Carruth
		5
		Swiss Army Man: Paul Dano, Daniel Radcliffe, Mary Elizabeth Winstead, Antonia Ribero, Shane Carruth
		Stir of Echoes: Kevin Bacon, Zachary David Cope, Kathryn Erbe, Illeana Douglas
		Grindhouse: Kurt Russell, Zoë Bell, Rosario Dawson, Vanessa Ferlito, Sydney Tamiia Poitier, Tracie Thoms, Rose McGowan, Mary Elizabeth Winstead, Tom Savini
		Frost/Nixon: Frank Langella, Michael Sheen, Kevin Bacon, Sam Rockwell
		Friday the 13th: Betsy Palmer, Adrienne King, Jeannine Taylor, Robbi Morgan, Kevin Bacon, Tom Savini"
	);

	final kevinBaconHimself = parseInput(
		"Kevin Bacon
		4
		The Air I Breathe: Brendan Fraser, Sarah Michelle Gellar, Andy Garcia, Kevin Bacon
		Balto: Kevin Bacon, Bob Hoskins, Bridget Fonda, Jim Cummings
		Grindhouse: Kurt Russell, Zoë Bell, Rosario Dawson, Vanessa Ferlito, Sydney Tamiia Poitier, Tracie Thoms, Rose McGowan, Mary Elizabeth Winstead, Tom Savini
		Sleepers: Kevin Bacon, Jason Patric, Brad Pitt, Robert De Niro, Dustin Hoffman"
	);

	final goingBig = parseInput(
		"Parnell Lewis
		10
		Mr. 3000: Bernie Mac, Angela Bassett, Brian J. White, Chris Noth, Tony Lee Gratz
		Wasted: David Kopriva, Alex Wilder, A.J. Laird, Oliver Grant, Natalie Matthai, Michael Oilar
		My One and Only: Renée Zellweger, Logan Lerman, Kevin Bacon, Chris Noth
		Slice: Asha Coy, Francis Faye, David Kopriva, Barrett Lione-Seaton
		Chained to a Cowboy: Monty Kane, Tyree Jensen, Tony Lee Gratz, Michael Oilar
		True to Form: Parnell Lewis, Kelly Higgs, Asha Coy, Kiera Knightley
		Cop Car: Kevin Bacon, James Freedson-Jackson, Hays Wellford, Shea Whigham
		Apollo 13: Tom Hanks, Bill Paxton, Kevin Bacon, Gary Sinise
		Crazy, Stupid, Love.: Steve Carell, Ryan Gosling, Julianne Moore, Emma Stone, Kevin Bacon
		The Notebook: Rachel McAdams, Ryan Gosling, James Garner, Gena Rowlands"
	);

	final theBiggest = parseInput(
		"Anusha Viswanathan
		40
		The Air I Breathe: Brendan Fraser, Sarah Michelle Gellar, Andy Garcia, Kevin Bacon
		Diner: Steve Guttenberg, Mickey Rourke, Kevin Bacon, Daniel Stern
		The Bengali Night: Hugh Grant, Shabana Azmi, Supriya Pathak, John Hurt, Soumitra Chatterjee, Utpal Dutt
		Murder in the First: Christian Slater, Kevin Bacon, Gary Oldman, Embeth Davidtz
		Change of Habit: Elvis Presley, Mary Tyler Moore, Barbara McNair, Jane Elliot, Ed Asner
		Mission Dugga Dugga: Anusha Viswanathan, Rahul Dev Bose, Kheyali Dastidar, Priyanka Bhattacharjee
		The Two Companions: Priyanka Bhattacharjee, Aishi Roy
		Criminal Law: Gary Oldman, Kevin Bacon, Tess Harper, Karen Young
		Beauty Shop: Queen Latifah, Alicia Silverstone, Kevin Bacon, Djimon Hounsou
		My One and Only: Renée Zellweger, Logan Lerman, Kevin Bacon, Chris Noth
		Path O Prasad: Utpal Dutt, Soumitra Chatterjee, Ruma Guha Thakurta, Satya Bandopadhyay, Kheyali Dastidar
		Where the Truth Lies: Kevin Bacon, Colin Firth, Alison Lohman, David Hayman
		Tremors: Kevin Bacon, Fred Ward, Finn Carter, Michael Gross
		Hollow Man: Kevin Bacon, Elisabeth Shue, Josh Brolin, Kim Dickens
		Mr. 3000: Bernie Mac, Angela Bassett, Brian J. White, Chris Noth, Tony Lee Gratz
		Taking Chance: Kevin Bacon, Tom Aldredge, Nicholas Art, Blanche Baker
		Cop Car: Kevin Bacon, James Freedson-Jackson, Hays Wellford, Shea Whigham
		Stir of Echoes: Kevin Bacon, Zachary David Cope, Kathryn Erbe, Illeana Douglas
		Sleepers: Kevin Bacon, Jason Patric, Brad Pitt, Robert De Niro, Dustin Hoffman
		Chatrapathi: Chatrapathi Sekhar, Prabhas, Bhanupriya, Shafi, Pradeep Ram Singh Rawat, L. B. Sriram
		The Big Picture: Kevin Bacon, Jennifer Jason Leigh, Emily Longstreth, J.T. Walsh
		Jayne Mansfield's Car: Kevin Bacon, Tippi Hedren, Shawnee Smith, Ray Stevenson, John Hurt
		Friday the 13th: Betsy Palmer, Adrienne King, Jeannine Taylor, Robbi Morgan, Kevin Bacon, Tom Savini
		R.I.P.D: Ryan Reynolds, Jeff Bridges, Mary-Louise Parker, Kevin Bacon
		Balto: Kevin Bacon, Bob Hoskins, Bridget Fonda, Jim Cummings
		Wasted: David Kopriva, Alex Wilder, A.J. Laird, Oliver Grant, Natalie Matthai, Michael Oilar
		The Woodsman: Kevin Bacon, Kyra Sedgwick, Yasiin Bey, David Alan Grier
		RRR: N.T. Rama Rao Jr., Ram Charan, Olivia Morris, Ray Stevenson, Alison Doody, Chatrapathi Sekhar
		Crazy, Stupid, Love.: Steve Carell, Ryan Gosling, Julianne Moore, Emma Stone, Kevin Bacon
		Apollo 13: Tom Hanks, Bill Paxton, Kevin Bacon, Gary Sinise
		The Notebook: Rachel McAdams, Ryan Gosling, James Garner, Gena Rowlands
		Flatliners: Kiefer Sutherland, Kevin Bacon, Julia Roberts, William Baldwin
		Clueless: Alicia Silverstone, Stacey Dash, Brittany Murphy, Paul Rudd
		Chained to a Cowboy: Monty Kane, Tyree Jensen, Tony Lee Gratz, Michael Oilar
		Grindhouse: Kurt Russell, Zoë Bell, Rosario Dawson, Vanessa Ferlito, Sydney Tamiia Poitier, Tracie Thoms, Rose McGowan, Mary Elizabeth Winstead, Tom Savini
		Picture Perfect: Jennifer Aniston, Jay Mohr, Kevin Bacon, Olympia Dukakis
		Frost/Nixon: Frank Langella, Michael Sheen, Kevin Bacon, Sam Rockwell
		Swiss Army Man: Paul Dano, Daniel Radcliffe, Mary Elizabeth Winstead, Antonia Ribero, Shane Carruth
		Slice: Asha Coy, Francis Faye, David Kopriva, Barrett Lione-Seaton
		Wild Things: Kevin Bacon, Neve Campbell, Matt Dillon, Denise Richards"
	);
}
