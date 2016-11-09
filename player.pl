
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