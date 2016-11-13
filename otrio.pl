:-use_module(library(lists)).
:-use_module(library(random)).
:- dynamic  letra/ 1, board / 3, mode / 2.
:- include('testes.pl').
:- include('printBoard.pl').
:- include('board.pl').
:- include('player.pl').

otrio :-
                write('\33\[2J'),
                nl,
                nl,
                nl,      
            write('                      Play Otrio                            '), nl,
                nl,
            write('                       WELCOME!                            '), nl,
                nl,
                nl,
            write(' Made By:                                               '), nl,
            write('     Joao Almeida ei10099                                '), nl,
            write('     Lazaro Costa up21045342                             '), nl,
                 nl,
            write('                Press enter to continue!                  '), nl,
 
        get_char(_), 
                menu.

menu:-
        repeat,
            format('Modo de jogo~n',[]),
            format('Player to Player    opcao:1 ~n',[]),
            format('Player to Boot      opcao:2 ~n',[]),
            format('Boot to Boot        opcao:3 ~n',[]),
            get_char(Mode),
            get_char(_),
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
        (Player ='H' ->retract(mode(1,X)), assert(mode(1,'H'));
        (Player ='A' ->retract(mode(1,X)), assert(mode(1,'A'));
        (Player ='M' ->retract(mode(1,X)), assert(mode(1,'H'))))),

        repeat,
               retract(board('c', N, C)),
               retract(letra(Letra)),
               retract(board(Letra, Numero, Board)),
               
               (Player = 'H' -> once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend)), NFinal is N-1;
         
               (Player = 'A' -> once(jogaPc(Letra, Numero, Nnovo, Board, Board1, C, Cend, Encontrou)),
                                   (Encontrou=1 -> NFinal is N-1;
                                                    NFinal = N1);
               (Player = 'M' -> retract(mode(1,Mode)), (Mode ='H'-> once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend)),
                                                                      NFinal is N-1;
                                                        (Mode = 'A'-> once(jogaPc(Letra, Numero, Nnovo, Board, Board1, C, Cend, Encontrou)),
                                                                     (Encontrou = 1 -> NFinal is N-1;
                                                                                      NFinal = N1))),
                                nextMode(Mode, ModeNovo), assert(mode(1, ModeNovo))))),
                
               proximaLetra(Letra, Proxima),
               assert(board(Letra,Nnovo, Board1)),
               assert(letra(Proxima)),

                 board('r', _, L),
                 board('b', _, R),
                 board('g', _, T),
                 board('p', _, B),
                 display(T, L, Cend, R, B),    

               assert(board('c', NFinal, Cend)),       
               ( gameTied(NFinal);
                  teste_get(Cend)).
   

teste_get(C):-
	((check_victory(C, PieceLetter),
	win(PieceLetter),
	nl);
    fail).

win(Leter) :-
            jogador(Leter,Number),
            convertLeter(Leter, Uppercase),
            write('              ______________________________                  '),nl,
            write('             |                              |                '),nl,
            write('             |                              |                '),nl,
           format('             |  Player  ~d  Leter  ~s  Winer  |                ~n',[Number, Uppercase]),
            write('             |                              |                '),nl,
            write('             |______________________________|                '),nl.

gameTied(NFinal):-
            ((NFinal=0)->
            write('              ____________________________           '),nl,
            write('             |                            |          '),nl,
            write('             |                            |          '),nl,
           format('             |         Game tied          |          ~n',[]),
            write('             |                            |          '),nl,
            write('             |____________________________|          '),nl; fail).

outro:-board('c', 27,C),
        encontraPecaBoard(C, 1, Encontrou, 'r', X, Y, 1).