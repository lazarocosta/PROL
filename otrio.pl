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

convertLeterToNumber('a',3).
convertLeterToNumber('b',2).
convertLeterToNumber('c',1).

% apanhar a linha
checkSource([Line|_], X, Y, Result):-
                        Y is 3, 
                        checkSourceAux(Line, X, Result).

checkSource([_|Tab], X, Y, Result):-
                        NewY is Y + 1, 
                        checkSource(Tab, X, NewY, Result).
% apanhar a peça
checkSourceAux([Piece|_], X, Result):-
                    ((Piece \== 'e' , X is 1) -> Result=1; Result=0).

checkSourceAux([_|Line], X, Result):-
                            NewX is X-1,
                            checkSourceAux(Line, NewX, Result).

%%%%%%%%%%%%%%%%
% ver a linha do tabuleiro
checkBoard([Line|_],Id, X, Y, Result):-
                        Y is 3, 
                        checkBoardAux(Line,Id, X, Result).

checkBoard([_|Tab],Id, X, Y, Result):-
                        NewY is Y + 1, 
                        checkBoard(Tab,Id, X, NewY, Result).

% ver o conjunto de 3 peças
checkBoardAux([Pieces|_],Id,  X, Result):-
                    X is 1,
                    checkBoardAuxPiece(Pieces, Id, Result).

checkBoardAux([_|Line],Id, X, Result):-
                            NewX is X-1,
                            checkBoardAux(Line,Id, NewX, Result).
% ver a peça 'r'
checkBoardAuxPiece([Piece|_], Id, Result):-
                    ((Piece == 'e' , Id is 1) -> Result=1; Result=0).

checkBoardAuxPiece([_|Pieces], Id, Result):-
                            NewId is Id-1,
                            checkBoardAuxPiece(Pieces, NewId, Result).

%%%%%%%%%%


joga(Peca, Source, SourceEnd, Tab, TabEnd):-
                repeat,
                verifica(Source, Result, Id, Y),!, 
                            repeat,
                            (Result is 1 -> verificaBoard(Tab, X, Y, Id, Result), 
                                            removePeca(Source, Y, Id, SourceEnd),
                                            inserePeca(Tab, X, Y, Id, Peca,TabEnd)).

verifica(Source, Result, X, Y):-
                write('coordenadas da peca a remover!'),nl,
                write('insira coordenada X'),nl,
                read(X),  
                valid(X),       
                write('insira coordenada Y'),nl,
                read(Y), 
                valid(Y),             
                checkSource(Source, X, Y, Result).


verificaBoard(Tab, X, Y, Id, Result):-
                write('coordenadas as novas coordenadas da peca'),nl,
                write('insira coordenada X'),nl,
                read(X),  
                valid(X),        
                write('insira coordenada Y'),nl,
                read(Y), 
                valid(Y),           
                checkBoard(Tab, Id, X, Y, Result).

valid(1).
valid(2).
valid(3).
valid(_):- write('invalid'),nl,fail.

