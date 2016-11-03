:-use_module(library(lists)).
:- include('testes.pl').
:- include('board.pl').

left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).

board(center, top, right, bottom, left).


getPeca(Linha, Coluna, Posicao, Peca):-
                centro(A),
                nth1(Linha, A, Listlinha),
                nth1(Coluna, Listlinha, ListPeca),
                nth1(Posicao, ListPeca, Peca).

setPeca(1, Peca, [_, B, C], [Peca, B, C]).
setPeca(2, Peca, [A, _, C], [A, Peca, C]).
setPeca(3, Peca, [A, B, _], [A, B, Peca]).

removePeca([Line|Tab], Y, Id, [Line|Res]):-
                        NewY is Y + 1,
                        removePeca(Tab, NewY, Id, Res).
                        
removePeca([Line|Tab], Y, Id, Res):-
                                Y is 3,
                                setPeca(Id, 'e', Line, Nova),
                                Res = [Nova|Tab].


inserePeca([Line|Tab], X, Y, Id, Peca, [Line|Res]):-
                        NewY is Y + 1,
                        inserePeca(Tab, X, NewY, Id, Peca, Res).

inserePeca([Line|Tab], X, Y, Id, Peca, Res):-
                        Y is 3, 
                        inserePecaAux(Line, X, Id, Peca, Nova),
                        Res = [Nova|Tab].

inserePecaAux([Line|Tab], X, Id, Peca, [Line|Res]):-
                        NewX is X - 1,
                        inserePecaAux(Tab, NewX, Id, Peca, Res).

inserePecaAux([Line|Tab], X, Id, Peca,[ Res|Tab]):-
                        X is 1,
                        setPeca(Id, Peca, Line, Nova),
                        Res = Nova.