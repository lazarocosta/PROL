
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
                    ((Piece == e) -> fail; true).

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
                format('jogador ~d ~n',[Numero]),
                peca(Peca, Peca1),
                format('Peca ~s ~n',[Peca1]),
                ((N1 == 0)->N2=0, SourceEnd=Source, TabEnd=Tab, nextPlayer(Peca);

                encontraProxima(Source,Peca, 0,3, Id, Y),
                                encontraPecaBoard(Tab, 3,Encontrou, e, Xnovo, Ynovo, Id),
                                (Encontrou == 1 ->  N2 is N1-1, removePeca(Source, Y, Id, SourceEnd),inserePeca(Tab, Xnovo, Ynovo, Id, Peca,TabEnd);
                                                N2=N1, SourceEnd=Source, TabEnd=Tab, nextPlayer(Peca))).

verifica(Source, X, Y, Peca):-
                repeat,                                               
                       jogador(Peca, Numero),
                       format('jogador ~d ~n',[Numero]),
                       peca(Peca, Peca1),
                       format('Peca ~s ~n',[Peca1]),
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
                    write('As novas coordenadas da peca'),nl,
                    write('insira coordenada X'),nl,
                    read(X),
                    valid(X),
                    write('insira coordenada Y'),nl,
                    read(Y),
                    valid(Y),
                  checkBoard(Tab,Id, X, Y).

convert(1,3).
convert(3,1).
convert(2,2).

peca('r','R').
peca('p','P').
peca('g','G').
peca('b','B').

nextPlayer(Peca):-
                format('Nao tem pecas disponiveis...proximo jogador ~n',[]).

valid(1).
valid(2).
valid(3).
valid(_):- write('invalid'),nl,nl,nl,nl,nl,fail.



 semPecas(NFinal):-
            ((NFinal=0)->format('Empate ~n',[]); fail).

%=====================0
encontraProxima([Pecas|Lines],Peca, X, 3, XFim, YFim):-
    XProximo is X+1,
     (1 >= XProximo, Pecas = [Peca,_,_]-> XFim=1, YFim=3;   
                                                (2 >= XProximo, Pecas = [_,Peca,_]-> XFim=2, YFim=3;  
                                                                            (3 >= XProximo, Pecas = [_,_,Peca]-> XFim=3, YFim=3;                                                                            
                                                                                    encontraProxima(Lines,Peca, 0, 2, XFim, YFim)))).
encontraProxima([Pecas|Lines],Peca, X, 2, XFim, YFim):-
    XProximo is X+1,  
     (1 >= XProximo, Pecas = [Peca,_,_]-> XFim=1, YFim=2;   
                                                (2 >= XProximo,  Pecas = [_,Peca,_]-> XFim=2, YFim=2;  
                                                                           (3 >= XProximo, Pecas = [_,_,Peca]-> XFim=3, YFim=2;                                                                                                                                     
                                                                                    encontraProxima(Lines,Peca, 0, 1, XFim, YFim)))).
encontraProxima([Pecas|_],Peca, X, 1, XFim, YFim):-
        XProximo is X+1,
        (XProximo = 4 ->fail;
                        (1 >= XProximo, Pecas = [Peca,_,_]-> XFim=1, YFim=1; 
                                            (2 >= XProximo,  Pecas = [_,Peca,_]-> XFim=2, YFim=1;  
                                                                        (3 >= XProximo, Pecas = [_,_,Peca]-> XFim=3, YFim=1;  
                                                                                                 fail)))).
%============
encontraPecaBoard([Line|Tab], 3, Encontrou, Peca, X, Y, Id):-
                 peca(Line, 3, Peca, Id, X),Y = 3, Encontrou=1;
                 encontraPecaBoard(Tab, 2,Encontrou, Peca, X, Y, Id).

encontraPecaBoard([Line|Tab], 2, Encontrou, Peca, X, Y, Id):-
                peca(Line, 3, Peca, Id, X),Y = 2,Encontrou=1;
                 encontraPecaBoard(Tab, 1,Encontrou, Peca, X, Y, Id).

encontraPecaBoard([Line|_], 1, Encontrou, Peca, X, Y, Id):-
                peca(Line, 3,Peca, Id, X),Y = 1,Encontrou=1;Encontrou=0.
%=====
peca([Pecas|Lines], 3, Peca, X, Y):-
                (X=1 ->(Pecas =[Peca,_,_]->Y=1 ); peca(Lines, 2, Peca, X, Y));
                (X=2 ->(Pecas =[_,Peca,_]->Y=1 ); peca(Lines, 2, Peca, X, Y));
                (X=3 ->(Pecas =[_,_,Peca]->Y=1 ); peca(Lines, 2, Peca, X, Y)).

peca([Pecas|Lines], 2, Peca, X, Y):-
                (X=1 -> (Pecas =[Peca,_,_]->Y=2 );  peca(Lines, 1, Peca, X, Y));
                (X=2 -> (Pecas =[_,Peca,_]->Y=2 ); peca(Lines, 1,Peca, X, Y));
                (X=3 -> (Pecas =[_,_,Peca]->Y=2 );  peca(Lines, 1, Peca, X, Y)).

peca([Pecas|_], 1 , Peca, X, Y):-
                (X=1 -> (Pecas =[Peca,_,_]->Y=3 );fail);
                (X=2 -> (Pecas =[_,Peca,_]->Y=3 );fail);
                (X=3 -> (Pecas =[_,_,Peca]->Y=3 );fail).