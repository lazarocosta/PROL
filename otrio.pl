:-use_module(library(lists)).
:- dynamic left/1, right/1, top/1, bottom/1, center/1, letra/1, board/2.
:- include('testes.pl').
:- include('board.pl').

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
                        
removePeca([Line|Tab], 3, Id, Res):-
                         setPeca(Id, 'e', Line, Nova),
                         Res = [Nova|Tab].

inserePeca([Line|Tab], X, Y, Id, Peca, [Line|Res]):-
                        NewY is Y + 1,
                        inserePeca(Tab, X, NewY, Id, Peca, Res).

inserePeca([Line|Tab], X, 3, Id, Peca, Res):-
                        inserePecaAux(Line, X, Id, Peca, Nova),
                        Res = [Nova|Tab].

inserePecaAux([Line|Tab], X, Id, Peca, [Line|Res]):-
                        NewX is X - 1,
                        inserePecaAux(Tab, NewX, Id, Peca, Res).

inserePecaAux([Line|Tab], 1, Id, Peca,[ Res|Tab]):-
                        setPeca(Id, Peca, Line, Nova),
                        Res = Nova.

convertLeterToNumber('a',3).
convertLeterToNumber('b',2).
convertLeterToNumber('c',1).

% apanhar a linha
checkSource([Line|_], X, 3):-
                        checkSourceAux(Line, X).

checkSource([_|Tab], X, Y):-
                        NewY is Y + 1, 
                        checkSource(Tab, X, NewY).
% apanhar a peça
checkSourceAux([Piece|_], 1):-
                    ((Piece == 'e') -> fail; true).

checkSourceAux([_|Line], X):-
                            NewX is X-1,
                            checkSourceAux(Line, NewX).

%%%%%%%%%%%%%%%%
% ver a linha do tabuleiro
checkBoard([Line|_],Id, X, 3):-
                        checkBoardAux(Line,Id, X).

checkBoard([_|Tab],Id, X, Y):-
                        NewY is Y + 1, 
                        checkBoard(Tab,Id, X, NewY).

% ver o conjunto de 3 peças
checkBoardAux([Pieces|_],Id, 1):-
                    checkBoardAuxPiece(Pieces, Id).

checkBoardAux([_|Line],Id, X):-
                            NewX is X-1,
                            checkBoardAux(Line,Id, NewX).
% ver a peça 'r'
checkBoardAuxPiece([Piece|_], 1):-
                    ((Piece \== 'e') -> fail; true).

checkBoardAuxPiece([_|Pieces], Id):-
                            NewId is Id-1,
                            checkBoardAuxPiece(Pieces, NewId).

%%%%%%%%%%


joga(Peca, Source, SourceEnd, Tab, TabEnd):-
                verifica(Source, Id, Y, Peca),!, 
                 verificaBoard(Tab, Xnovo, Ynovo, Id),
                 removePeca(Source, Y, Id, SourceEnd),
                 inserePeca(Tab, Xnovo, Ynovo, Id, Peca,TabEnd).

verifica(Source, X, Y, Peca):-
                repeat,
                write('coordenadas da peca a remover!'),nl,
                write('insira coordenada X'),nl,
                read(X),
                valid(X),   
                write('insira coordenada Y'),nl,
                ((Peca=='p'; Peca=='g') -> read(Y1), valid(Y1),convert(Y1, Y);
                                           read(Y), valid(Y)),
                 checkSource(Source, X, Y).         


verificaBoard(Tab, X, Y, Id):-
                repeat,
                write('coordenadas as novas coordenadas da peca'),nl,
                write('insira coordenada X'),nl,
                read(X), 
                valid(X),        
                write('insira coordenada Y'),nl,
                read(Y),
                valid(Y),           
                checkBoard(Tab, Id, X, Y).

convert(1,3).
convert(3,1).
convert(2,2).
valid(1).
valid(2).
valid(3).
valid(_):- write('invalid'),nl,fail.

