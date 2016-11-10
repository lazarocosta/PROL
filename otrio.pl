:-use_module(library(lists)).
:-use_module(library(random)).
:- dynamic  letra/ 1, board / 3, mode / 2.
:- include('testes_joao.pl').
:- include('printBoard.pl').
:- include('board.pl').
:- include('player.pl').

otrio:-
        repeat,
            format('Modo de jogo~n',[]),
            format('Player to Player    opcao:1 ~n',[]),
            format('Player to Boot      opcao:2 ~n',[]),
            format('Boot to Boot        opcao:3 ~n',[]),
            read(Mode),
            valid(Mode),
        convertToLeter(Mode, Mode1),
        game(Mode1).

init:-
        board('r',_, L),
        board('b',_, R),
        board('g',_, T),
        board('p',_, B),
        board('c',_, C),
        display(T, L, C, R, B).

game(Player):-
        init,  
        (Player =='H' ->retract(mode(1,X)), assert(mode(1,'H'));
        (Player =='A' ->retract(mode(1,X)), assert(mode(1,'A'));
        (Player =='M' ->retract(mode(1,X)), assert(mode(1,'H'))))),

        repeat,
               retract(board('c', N, C)),
               retract(letra(Letra)),
               retract(board(Letra, Numero, Board)),
               
               (Player == 'H' -> once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend, 'H')), NFinal is N-1;
                                 
               (Player == 'A' -> once(jogaPc(Letra, Numero, Nnovo, Board, Board1, C, Cend, Encontrou)),
                                   (Encontrou==1 -> NFinal is N-1;
                                                    NFinal=N1);
               (Player == 'M' -> retract(mode(1,Mode)), (Mode=='H'-> once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend, 'H')),
                                                                      NFinal is N-1;
                                                        (Mode=='A'-> once(jogaPc(Letra, Numero, Nnovo, Board, Board1, C, Cend, Encontrou)),
                                                                     (Encontrou==1 -> NFinal is N-1;
                                                                                      NFinal = N1))),
                                nextMode(Mode, ModeNovo),assert(mode(1,ModeNovo))))),
                
               proximaLetra(Letra, Proxima),
               assert(board(Letra,Nnovo, Board1)),
               assert(letra(Proxima)),

              retract(board('r', N1, L)),
              retract(board('b', N2, R)),
              retract(board('g', N3, T)),
              retract(board('p', N4, B)),

               display(T, L, Cend, R, B),

               assert(board('r', N1, L)),
               assert(board('b', N2, R)),
               assert(board('g', N3, T)),
               assert(board('p', N4, B)),

               assert(board('c', NFinal, Cend)),          
               semPecas(NFinal);
               teste_get(Cend).