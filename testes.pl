left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).

board('l',[ [r, r, r], [r, r, r], [r, r, r] ]). %left

board('r',[ [b, b, b], [b, b, b], [b, b, b] ]). %right

board('t',[ [g, g, g], [g, g, g], [g, g, g] ]).%top

board('b',[ [p, p, p], [p, p, p], [p, p, p] ]).%bottom

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
                board('r',R),
                board('l',L),
                board('t',T),
                board('b',B),

                retract(letra(Letra)),
                retract(board(Letra, Board)),
                retract(board('c', C)),

                display(T, L, C, R, B),

                joga(Letra, Board, Board1, C, Cend),
                proximaLetra(Letra, Proxima),!,

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