
removeSide(Y, Id, Res):-
        left(A),
        removePeca(A, Y, Id, Res).

ins(X, Y, Id, Res):-
                 center(A),
                 inserePeca(A, X, Y, Id, 'p', Res).

game:-
         left(L),
         center(C),
         top(T),
         right(R),
         bottom(B),
         write('jogador 1'), nl,
         joga('r', L, Lend,  C, Cend),
         display(T, Lend, Cend, R, B), nl,

         write('jogador 2'), nl,
         joga('g', T, Tend,  Cend, Cend1),
         display(Tend, Lend, Cend1, R, B),

         nl,
         write('jogador 1'), nl,
         joga('b', R, Rend,  Cend1, Cend2),
         display(Tend, Lend, Cend2, Rend, B),

         nl,
         write('jogador 2'),nl,
         joga('p', B, Bend,  Cend2, Cend3),
         display(Tend, Lend, Cend2, Rend, Bend).


         