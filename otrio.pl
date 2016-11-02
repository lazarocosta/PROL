esq([ [r, r, r], [r, r, r], [r, r, r] ]).

dir([ [b, b, b], [b, b, b], [b, b, b] ]).

cima([ [g, g, g], [g, g, g], [g, g, g] ]).

baixo([ [p, p, p], [p, p, p], [p, p, p] ]).

centro([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).


board(centro, cima, esq, dir, baixo).


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


printPecas([],N).

printboard([A|R1],[B|R2],[C|R3], N):-
    (N == 0 -> space; write(N), write('  ')),
    printPecas(A,2),
     printLine(B),
     printPecas(C,2),
     write('||'),
    nl,
   N1 is N-1,
    printboard(R1, R2, R3, N1).

printboard([],[],[], N).

printBottom:-
	shortSeparation,
	write('                       A             B             C').


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%defines%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

display:-
        cima(A),
        esq(B),
        centro(C),
        dir(D),
        baixo(E),
        shortSeparation,
        printboardTop(A),
        separation,
        printboard(B,C,D,3),
        separation,
        printboardTop(E),
        printBottom.

include:-use_module(library(lists)).

getPeca(Linha, Coluna, Posicao, Peca):-
                centro(A),
                nth1(Linha, A, Listlinha),
                nth1(Coluna, Listlinha, ListPeca),
                nth1(Posicao, ListPeca, Peca).

setPeca(1, Peca, [_, B, C], [Peca, B, C]).
setPeca(2, Peca, [A, _, C], [A, Peca, C]).
setPeca(3, Peca, [A, B, _], [A, B, Peca]).


%% alteraColuna(Peca, [Coluna, C2, C3], [Nova, C2,C3]):-
                setpeca(Peca, Coluna, Nova).

%% alteraColuna(Peca, [C1, Coluna, C3], [C1, Nova,C3]):-
                setpeca(Peca, Coluna, Nova).

%% alteraColuna(Peca, [C1, C2, Coluna], [C1, C2, Nova]):-
                setpeca(Peca, Coluna, Nova).





