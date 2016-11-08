left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).

board('r',[ [r, r, r], [r, r, r], [r, r, r] ]). %left

board('b',[ [b, b, b], [b, b, b], [b, b, b] ]). %right

board('g',[ [g, g, g], [g, g, g], [g, g, g] ]).%top

board('p',[ [p, p, p], [p, p, p], [p, p, p] ]).%bottom

board('c',[ [ [e, e, e], [e, e, e], [e, e, e] ],%center
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

novo:-
        repeat,
              retract(board('c', C)),
              retract(board('r', L)),
              retract(board('b', R)),
              retract(board('g', T)),
              retract(board('p', B)),

               display(T, L, C, R, B),

               assert(board('r', L)),
               assert(board('b', R)),
               assert(board('g', T)),
               assert(board('p', B)),

               retract(letra(Letra)),
               retract(board(Letra, Board)),
               once(joga(Letra, Board, Board1, C, Cend)),
               proximaLetra(Letra, Proxima),

               assert(board(Letra, Board1)),
               assert(board('c', Cend)),
               assert(letra(Proxima)),
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
