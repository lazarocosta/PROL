
printLine([C|R]):-
	write('||'),
        printPecas(C,2),
	printLine(R).

printLine([]):-
            write('||').

printboardTop(A):-
          space,
          printLine(A),
          nl.


printPecas([C|R], N):-
                write(' '),
                traduz(C),
                 write(' '),
               (N > 0 -> write('-'); 
                        write(' ') ),
                N1 is N-1,
                printPecas(R, N1).


printPecas([],_).

printboard([A|R1],[B|R2],[C|R3], N):-
                (N == 0 -> space; write(N), write('  ')),
                printPecas(A,2),
                printLine(B),
                printPecas(C,2),
                write('||'),
                nl,
                N1 is N-1,
                printboard(R1, R2, R3, N1).

printboard([],[],[], _).

printBottom:-
	shortSeparation,
	write('                       A             B            C').

separation:- write('    --------------------------------------------------------------------'), 
                nl.
shortSeparation:- write('                ------------------------------------------'),
                nl.
space:- write('               ').
traduz('p'):- write('P').
traduz('g'):- write('G').
traduz('r'):- write('R').
traduz('b'):- write('B').
traduz('e'):- write(' ').

display(Top, Left, Center, Right, Bottom):-
                shortSeparation,
                printboardTop(Top),
                separation,
                printboard(Left, Center, Right, 3),
                separation,
                printboardTop(Bottom),
                printBottom, nl.