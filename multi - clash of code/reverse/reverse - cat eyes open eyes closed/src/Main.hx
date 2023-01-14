import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;

/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1

Input
6
                   _..
  /}_{\           /.-'
 ( o o )-.___...-'/
 ==._.==         ;
      \ i _..._ /,
      {_;/   {_//

		Expected output
                   _..
  /}_{\           /.-'
 ( x x )-.___...-'/
 ==._.==         ;
      \ i _..._ /,
      {_;/   {_//


02 Test 2

Input
12
             (`,---.')  (\
              (o,_,o)    ))
             -=>_Y_<=- _,;'
               /`"'\.-'.'
             .'     `<'
             | ;   ; |
             |`,   , |
              \ ;`; /
               ||,||
              /|| ||\
             (,|( )|,)
              (,,Y,,)

Expected output
             (`,---.')  (\
              (x,_,x)    ))
             -=>_Y_<=- _,;'
               /`"'\.-'.'
             .'     `<'
             | ;   ; |
             |`,   , |
              \ ;`; /
               ||,||
              /|| ||\
             (,|( )|,)
              (,,Y,,)

03 Test 3

Input
7
      /\_/\
 /\  / o o \
//\\ \~(*)~/
`  \/   ^ /
   | \|| ||
   \ '|| ||
    \)()-())

Expected output
      /\_/\
 /\  / x x \
//\\ \~(*)~/
`  \/   ^ /
   | \|| ||
   \ '|| ||
    \)()-())

04 Test 4

Input
7
    /\_____/\
   /  o   o  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)

Expected output
    /\_____/\
   /  x   x  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)

05 Test 5
Input
11
 /\     /\
{  `---'  }
{  o   o  }
~~>  V  <~~
 \  \|/  /
  `-----'____
  /     \    \_
 {       }\  )_\_   _
 |  \_/  |/ /  \_\_/ )
  \__/  /(_/     \__/
    (__/

Expected output
 /\     /\
{  `---'  }
{  x   x  }
~~>  V  <~~
 \  \|/  /
  `-----'____
  /     \    \_
 {       }\  )_\_   _
 |  \_/  |/ /  \_\_/ )
  \__/  /(_/     \__/
    (__/

*/

function main() {

	final n = parseInt( readline());
	final rows = [for( _ in 0...n ) readline().replace( "o", "x" )].join("\n");

	print( rows );
}
