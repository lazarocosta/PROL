
removeSide(Y, Id, Res):-
        left(A),
        removePeca(A, Y, Id, Res).

ins(X, Y, Id, Res):-
                 center(A),
                 inserePeca(A, X, Y, Id, 'p', Res).