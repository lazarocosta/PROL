
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
         joga('p', L, Lend,  C, Cend),
         display(T, Lend, Cend, R, B).