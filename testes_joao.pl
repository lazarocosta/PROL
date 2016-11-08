% condições de fim de jogo

% 1. otrio por ordem (de)crescente numa linha - horizontal / vertical / diagonal
% 2. otrio por peças iguais em linha - horizontal / vertical / diagonal
% 3. otrio por colocação das 3 peças concêntricas
% 4. empate - nenhum jogador pode fazer mais movimentos


left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).


%%%% tabuleiro inicial base

left([ [r, r, r], [r, r, r], [r, r, r] ]).

right([ [b, b, b], [b, b, b], [b, b, b] ]).

top([ [g, g, g], [g, g, g], [g, g, g] ]).

bottom([ [p, p, p], [p, p, p], [p, p, p] ]).

center([ [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ],
         [ [e, e, e], [e, e, e], [e, e, e] ] ]).
		 

%%%%% tabuleiros de otrio iguais em linha

% iguais em linha_horizontal 1
	left_iguais_horiz1([ [r, r, r], [r, r, r], [r, r, r] ]).

	right_iguais_horiz1([ [b, e, b], [b, b, e], [b, b, b] ]).

	top_iguais_horiz1([ [e, g, g], [e, g, g], [e, g, g] ]).

	bottom_iguais_horiz1([ [p, p, p], [p, p, p], [p, p, p] ]).

	center_iguais_horiz1([ [ [e, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [e, e, e] ],
						[ [g, b, e], [g, e, e], [g, e, b] ] ]).

% iguais em linha_horizontal 2
	left_iguais_horiz2([ [r, r, r], [r, r, r], [r, r, r] ]).

	right_iguais_horiz2([ [b, e, b], [b, b, b], [b, b, b] ]).

	top_iguais_horiz2([ [e, g, g], [g, g, g], [g, g, g] ]).

	bottom_iguais_horiz2([ [p, e, p], [p, e, p], [p, e, p] ]).

	center_iguais_horiz2([ [ [g, p, e], [e, p, e], [e, b, p] ],
						[ [e, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [e, e, e] ] ]).
		 
% iguais em linha_vertical 1
	left_iguais_vert1([ [r, r, r], [e, r, r], [r, r, r] ]).

	right_iguais_vert1([ [b, b, b], [b, e, b], [b, b, b] ]).

	top_iguais_vert1([ [g, g, g], [g, g, g], [g, g, g] ]).

	bottom_iguais_vert1([ [p, p, e], [p, p, e], [p, p, e] ]).

	center_iguais_vert1([ [ [e, e, e], [e, e, p], [e, e, e] ],
						[ [e, e, e], [e, b, p], [e, e, e] ],
						[ [e, e, e], [r, e, p], [e, e, e] ] ]).
			 
% iguais em linha_vertical 2
	left_iguais_vert2([ [r, r, r], [r, r, r], [r, r, e] ]).

	right_iguais_vert2([ [e, b, b], [e, b, b], [e, b, b] ]).

	top_iguais_vert2([ [g, g, g], [g, g, g], [g, g, g] ]).

	bottom_iguais_vert2([ [p, p, p], [p, e, p], [p, p, p] ]).

	center_iguais_vert2([ [ [e, e, e], [e, e, e], [b, p, e] ],
						[ [e, e, e], [e, e, e], [b, e, e] ],
						[ [e, e, e], [e, e, e], [b, e, r] ] ]).


%%%%% tabuleiros de otrio crescente em linha

% linha cresc_hor1
	left_linha_cresc_hor1([ [r, r, r], [r, e, e], [r, r, r] ]).

	right_linha_cresc_hor1([ [b, b, b], [b, b, b], [b, b, b] ]).

	top_linha_cresc_hor1([ [g, g, e], [e, e, e], [g, g, g] ]).

	bottom_linha_cresc_hor1([ [p, p, e], [p, p, p], [e, p, p] ]).

	center_linha_cresc_hor1([ [ [e, r, e], [e, e, e], [e, e, r] ],
						[ [e, e, g], [e, e, e], [e, e, e] ],
						[ [g, e, p], [p, g, e], [e, e, g] ] ]).
			 
% linha cresc_hor2
	left_linha_cresc_hor2([ [r, r, r], [r, r, r], [e, e, e] ]).

	right_linha_cresc_hor2([ [b, e, b], [b, b, b], [b, b, b] ]).

	top_linha_cresc_hor2([ [g, g, g], [g, g, g], [g, g, g] ]).

	bottom_linha_cresc_hor2([ [p, p, p], [p, p, e], [p, p, p] ]).

	center_linha_cresc_hor2([ [ [e, e, e], [e, e, e], [e, e, e] ],
						[ [r, b, e], [e, r, p], [e, e, r] ],
						[ [e, e, e], [e, e, e], [e, e, e] ] ]).
			 
% linha cresc_diag1
	left_linha_cresc_diag1([ [r, r, e], [r, r, r], [r, r, r] ]).

	right_linha_cresc_diag1([ [b, b, b], [b, b, b], [b, b, b] ]).

	top_linha_cresc_diag1([ [g, g, e], [g, e, g], [e, g, g] ]).

	bottom_linha_cresc_diag1([ [p, p, p], [e, e, p], [p, p, p] ]).

	center_linha_cresc_diag1([ [ [g, e, r], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, g, e], [e, e, e] ],
						[ [e, e, e], [p, p, e], [e, e, g] ] ]).
			 
% linha cresc_diag2
	left_linha_cresc_diag2([ [r, e, r], [r, r, r], [r, r, r] ]).

	right_linha_cresc_diag2([ [b, b, b], [b, b, e], [b, b, b] ]).

	top_linha_cresc_diag2([ [g, g, g], [e, g, g], [e, g, g] ]).

	bottom_linha_cresc_diag2([ [p, p, p], [e, e, e], [p, p, p] ]).

	center_linha_cresc_diag2([ [ [e, e, e], [g, e, e], [g, e, p] ],
						[ [e, e, e], [e, p, b], [e, e, e] ],
						[ [p, r, e], [e, e, e], [e, e, e] ] ]).


%%%%% tabuleiros de otrio concentrico

% concentrico 1
	left_linha_conc1([ [r, r, r], [e, r, r], [r, r, r] ]).

	right_linha_conc1([ [b, b, b], [b, b, b], [e, e, e] ]).

	top_linha_conc1([ [g, g, e], [g, g, g], [g, g, g] ]).

	bottom_linha_conc1([ [p, p, p], [p, p, p], [p, e, p] ]).

	center_linha_conc1([ [ [r, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, g], [e, p, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [b, b, b] ] ]).
			 
% concentrico 2
	left_linha_conc2([ [r, r, r], [r, r, e], [r, r, r] ]).

	right_linha_conc2([ [b, b, b], [b, e, b], [b, b, b] ]).

	top_linha_conc2([ [e, g, g], [g, e, g], [g, g, e] ]).

	bottom_linha_conc2([ [e, p, p], [p, p, p], [p, p, p] ]).

	center_linha_conc2([ [ [e, e, e], [e, e, e], [e, e, r] ],
						[ [p, e, e], [e, e, e], [e, b, e] ],
						[ [e, e, e], [g, g, g], [e, e, e] ] ]).


%%%%% tabuleiros de empate

% TO-DO






teste_print:-
	left(L),
	center(C),
	top(T),
	right(R),
	bottom(B),
	nl,
	display(T, L, C, R, B), nl.