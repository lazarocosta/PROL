boar( [ [ [g, g, g], [g, g, g], [g, g, g] ],
[ [r, r, r], [e, e, e], [e, e, e], [e, e, e], [b, b, b] ],
[ [r, r, r], [e, e, e], [e, e, e], [e, e, e], [b, b, b] ],
[ [r, r, r], [e, e, e], [e, e, e], [e, e, e], [b, b, b] ],
[ [p, p, p], [p, p, p], [p, p, p] ] ] ).



init([C|R]):-
        shortSeparation,
        printboardTop(C),
        printboard(R,3).


printboardTop(C):-
          space, 
          printLine(C), 
          separation.


printboard([C|R], N):-
    (N == 0 -> space; write(N), write('  ')),
    printLine(C),
    (N > 0 -> separation; write('')),
    N1 is N-1,
    printboard(R, N1).


printboard([], N):-
	shortSeparation,
	write('                        A             B             C').


printLine([C|R]):-
	write('||'),
    printPecas(C,2),
	printLine(R).


printLine([]):-
            write('||'),
	        nl.

printPecas([C|R], N):-
                write(' '),
                traduz(C),
                 write(' '),
               (N > 0 -> write('-'); 
                        write(' ') ),
                N1 is N-1,
                printPecas(R, N1).

printPecas([],N).

separation:- write('   -----------------------------------------------------------------------'), 
                nl.
shortSeparation:- write('                 -------------------------------------------'),
                nl.

space:- write('                 ').
traduz('p'):- write('P').
traduz('g'):- write('G').
traduz('r'):- write('R').
traduz('b'):- write('B').
traduz('e'):- write(' ').

otrio:-
         board(A), init(A).