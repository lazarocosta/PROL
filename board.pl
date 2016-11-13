
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

% encontrou a linha
checkSource([Line|_], X, 3):-
                        checkSourceAux(Line, X).

checkSource([_|Tab], X, Y):-
                        NewY is Y + 1,
                        checkSource(Tab, X, NewY).
%verifica Peca
checkSourceAux([Piece|_], 1):-
                    ((Piece = 'e') -> fail; true).

checkSourceAux([_|Line], X):-
                            NewX is X-1,
                            checkSourceAux(Line, NewX).
%%%%%%%%%%%%%%%%
% encontrou a linha do tabuleiro
checkBoard([Line|_],Id, X, 3):-
                        checkBoardAux(Line,Id, X).

checkBoard([_|Tab],Id, X, Y):-
                        NewY is Y + 1,
                        checkBoard(Tab,Id, X, NewY).
%encontrou o conjunto das 3 peças
checkBoardAux([Pieces|_],Id, 1):-
                    checkBoardAuxPiece(Pieces, Id).

checkBoardAux([_|Line],Id, X):-
                            NewX is X-1,
                            checkBoardAux(Line,Id, NewX).
% verifica a peça
checkBoardAuxPiece([Piece|_], 1):-
                    ((Piece \== 'e') -> fail; true).

checkBoardAuxPiece([_|Pieces], Id):-
                            NewId is Id-1,
                            checkBoardAuxPiece(Pieces, NewId).
%%%%%%%%%%

joga(Peca, N1, N2, Source, SourceEnd, Tab, TabEnd):-
                ((N1 == 0)->N2=0, SourceEnd=Source, TabEnd=Tab, nextPlayer(Peca) ;
                            N2 is N1-1,
                            verifica(Source, Id, Y, Peca),!,
                            verificaBoard(Tab, Xnovo, Ynovo, Id),
                            removePeca(Source, Y, Id, SourceEnd),
                            inserePeca(Tab, Xnovo, Ynovo, Id, Peca,TabEnd)).

jogaPc(Peca, N1, N2, Source, SourceEnd, Tab, TabEnd, Encontrou):-
                jogador(Peca, Numero),
                format('Player ~d ~n',[Numero]),
                peca(Peca, Peca1),
                format('Piece ~s ~n',[Peca1]),
                ((N1 == 0)->N2=0, SourceEnd=Source, TabEnd=Tab, nextPlayer(Peca);
                            (N1 = 9 -> verificaRandom(Source, X, Y); encontraProxima(Source,Peca, 0,3, Id, Y)),
            
                            encontraPecaBoard(Tab, 3,Encontrou, e, Xnovo, Ynovo, Id),
                            (Encontrou = 1 ->  N2 is N1-1, removePeca(Source, Y, Id, SourceEnd),inserePeca(Tab, Xnovo, Ynovo, Id, Peca,TabEnd));
                             (Encontrou = 0 ->N2=N1, SourceEnd=Source, TabEnd=Tab, nextPlayer(Peca))).

verificaRandom(Source,X, Y):-
                        random(1,4, X),
                        random(1,4, Y),
                        checkSource(Source, X, Y).

verifica(Source, X, Y, Peca):-
                repeat,
                       nl,
                       nl,                                            
                       jogador(Peca, Numero),
                       format('Player ~d ~n',[Numero]),
                       peca(Peca, Peca1),
                       format('Piece ~s ~n',[Peca1]),
                       nl,
                        write('Coordinates of the piece to be removed'),nl,
                        write('insert coordinate X'),nl,
                        get_char(X1),
                        get_char(_),
                        number(X1, X),
                        write('insert coordinate Y'),nl,
                        ((Peca=='p'; Peca=='g') ->  get_char(Y1),get_char(_),convert(Y1, Y);
                                                    get_char(Y1),get_char(_),number(Y1, Y)),
                         checkSource(Source, X, Y).

verificaBoard(Tab, X, Y, Id):-
                repeat,  
                    nl,
                    nl,
                    write('New piece coordinates'),nl,
                    write('insert coordinate X'),nl,
                    get_char(X1),
                    get_char(_),
                    number(X1, X),
                    write('insert coordinate Y'),nl,
                    get_char(Y1),
                    get_char(_),
                    number(Y1, Y),
                    checkBoard(Tab,Id, X, Y).
number('1', 1).
number('2', 2).
number('3', 3).

convert('1', 3).
convert('3', 1).
convert('2', 2).

nextPlayer(Peca):-
                format('No available pieces...next player ~n',[]).              
%=====================0
encontraProxima([],_, _, _, _, _):-fail.
encontraProxima([Pecas|Lines],Peca, X, N, XFim, YFim):-
    XProximo is X+1,
     (1 >= XProximo, Pecas = [Peca,_,_]-> XFim=1, YFim=N;   
                                                (2 >= XProximo, Pecas = [_,Peca,_]-> XFim=2, YFim=N;  
                                                                            (3 >= XProximo, Pecas = [_,_,Peca]-> XFim=3, YFim=N;                                                                                                                                                            
                                                                            N1 is N -1, encontraProxima(Lines,Peca, 0, N1, XFim, YFim)))).
encontraPecaBoard([_], Encontrou, _, _, _, _):-Encontrou=0.
encontraPecaBoard([Line|Tab], N, Encontrou, Peca, X, Y, Id):-
                 peca(Line, 1, Peca, Id, X),Y = N, Encontrou=1;
                 N1 is N-1,
                 encontraPecaBoard(Tab,N1, Encontrou, Peca, X, Y, Id).
%=====
peca([], _ , _, _, _):- fail.
peca([Pecas|Lines], N, Peca, X, Y):-
                (X=1 ->(Pecas =[Peca,_,_]->Y = N ); N1 is N + 1, peca(Lines, N1, Peca, X, Y));
                (X=2 ->(Pecas =[_,Peca,_]->Y = N ); N1 is N + 1, peca(Lines, N1, Peca, X, Y));
                (X=3 ->(Pecas =[_,_,Peca]->Y = N ); N1 is N + 1, peca(Lines, N1, Peca, X, Y)).