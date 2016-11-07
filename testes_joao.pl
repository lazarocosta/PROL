center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).

printPecas([C|R], N):-
                write(' '),
                traduz(C),
                 write(' '),
               (N > 0 -> write('-'); 
                        write(' ') ),
                N1 is N-1,
                printPecas(R, N1).		 
		 
printboard([C|R3], N):-
                (N == 0 -> space; write(N), write('  ')),
                printPecas(C,2),
                write('||'),
                nl,
                N1 is N-1,
                printboard(R1, R2, R3, N1).
				

test :-
	printbard(center, 3).