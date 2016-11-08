left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).

board('r', 9,[ [r, r, r], [r, r, r], [r, r, r] ]). %tabuleiro letra/ numero de peças/ tabuleiro

board('b', 9,[ [b, b, b], [b, b, b], [b, b, b] ]). %right

board('g', 9,[ [g, g, g], [g, g, g], [g, g, g] ]).%top

board('p', 9,[ [p, p, p], [p, p, p], [p, p, p] ]).%bottom

board('c', 9,[ [ [e, e, e], [e, e, e], [e, e, e] ],%center
               [ [e, e, e], [e, e, e], [e, e, e] ],
               [ [e, e, e], [e, e, e], [e, e, e] ] ]).

letra('r').

proximaLetra('r', 'g'). % L--T
proximaLetra('g', 'b'). % T--R
proximaLetra('b', 'p'). % R--B
proximaLetra('p', 'r'). % B--L

jogador('r',1).
jogador('g',2).
jogador('b',1).
jogador('p',2).
init:-
        board('r',_, L),
        board('b',_, R),
        board('g',_, T),
        board('p',_, B),
        board('c',_, C),
        display(T, L, C, R, B).


novo:-
        init,
        repeat,
               retract(board('c', N, C)),
               retract(letra(Letra)),
               retract(board(Letra, Numero, Board)),
               once(joga(Letra, Numero, Nnovo, Board, Board1, C, Cend)),
               proximaLetra(Letra, Proxima),
               assert(board(Letra,Nnovo, Board1)),
               assert(letra(Proxima)),


              retract(board('r', N1, L)),
              retract(board('b', N2, R)),
              retract(board('g', N3, T)),
              retract(board('p', N4, B)),

               display(T, L, C, R, B),

               assert(board('r', N1, L)),
               assert(board('b', N2, R)),
               assert(board('g', N3, T)),
               assert(board('p', N4, B)),

               assert(board('c', N, Cend)),
  
               fail.


game:-
        repeat,
         left(L),
         center(C),
         top(T),
         right(R),
         bottom(B),
         write('jogador 1'), nl,
         write('letra R'), nl,
         joga('r', L, Lend,  C, Cend),
         display(T, Lend, Cend, R, B), nl,

         write('jogador 2'), nl,
         write('letra G'), nl,
         joga('g', T, Tend,  Cend, Cend1),
         display(Tend, Lend, Cend1, R, B),

         nl,
         write('jogador 1'), nl,
         write('letra B'), nl,
         joga('b', R, Rend,  Cend1, Cend2),
         display(Tend, Lend, Cend2, Rend, B),

         nl,
         write('jogador 2'),nl,
         write('letra P'), nl,
         joga('p', B, Bend,  Cend2, Cend3),
         display(Tend, Lend, Cend3, Rend, Bend).
