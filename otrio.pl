:-use_module(library(lists)).
:-use_module(library(random)).
:- dynamic left/1, right/1, top/1, bottom/1, center/1, letra/1, board/3.
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


 convertToLeter(1,'H').
 convertToLeter(2,'M').
 convertToLeter(3,'A').

init:-
        board('r',_, L),
        board('b',_, R),
        board('g',_, T),
        board('p',_, B),
        board('c',_, C),
        display(T, L, C, R, B).


game('H'):-
        init,
        repeat,
               retract(board('c', N, C)),
               retract(letra(Letra)),
               retract(board(Letra, Numero, Board)),
               once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend, 'H')),
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

               assert(board('c', N, Cend)),
               semPecas(N1,N2, N3, N4).



