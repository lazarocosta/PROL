% condições de fim de jogo

% 1. otrio por ordem (de)crescente numa linha - horizontal / vertical / diagonal
% 2. otrio por peças iguais em linha - horizontal / vertical / diagonal
% 3. otrio por colocação das 3 peças concêntricas
% 4. empate - nenhum jogador pode fazer mais movimentos
		 		 
getPeca(Centro, Linha, Coluna, Posicao, Peca):-
                nth1(Linha, Centro, Listlinha),
                nth1(Coluna, Listlinha, ListPeca),
                nth1(Posicao, ListPeca, Peca).

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
	center_iguais_horiz1([ [ [e, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [e, e, e] ],
						[ [g, b, e], [g, e, e], [g, e, b] ] ]).

% iguais em linha_horizontal 2
	center_iguais_horiz2([ [ [g, p, e], [e, p, e], [e, b, p] ],
						[ [e, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [e, e, e] ] ]).
		 
% iguais em linha_vertical 1
	center_iguais_vert1([ [ [e, e, e], [e, e, p], [e, e, e] ],
						[ [e, e, e], [e, b, p], [e, e, e] ],
						[ [e, e, e], [r, e, p], [e, e, e] ] ]).
			 
% iguais em linha_vertical 2
	center_iguais_vert2([ [ [e, e, e], [e, e, e], [b, p, e] ],
						[ [e, e, e], [e, e, e], [b, e, e] ],
						[ [e, e, e], [e, e, e], [b, e, r] ] ]).


%%%%% tabuleiros de otrio crescente em linha

% linha cresc_hor1
	center_linha_cresc_hor1([ [ [e, r, e], [e, e, e], [e, e, r] ],
						[ [e, e, g], [e, e, e], [e, e, e] ],
						[ [g, e, p], [p, g, e], [e, e, g] ] ]).
			 
% linha cresc_hor2
	center_linha_cresc_hor2([ [ [e, e, e], [e, e, e], [e, e, e] ],
						[ [r, b, e], [e, r, p], [e, e, r] ],
						[ [e, e, e], [e, e, e], [e, e, e] ] ]).
			 
% linha cresc_diag1
	center_linha_cresc_diag1([ [ [g, e, r], [e, e, e], [e, e, e] ],
						[ [e, e, e], [e, g, e], [e, e, e] ],
						[ [e, e, e], [p, p, e], [e, e, g] ] ]).
			 
% linha cresc_diag2
	center_linha_cresc_diag2([ [ [e, e, e], [g, e, e], [g, e, p] ],
						[ [e, e, e], [e, p, b], [e, e, e] ],
						[ [p, r, e], [e, e, e], [e, e, e] ] ]).


%%%%% tabuleiros de otrio concentrico

% concentrico 1
	center_linha_conc1([ [ [r, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, g], [e, p, e], [e, e, e] ],
						[ [e, e, e], [e, e, e], [b, b, b] ] ]).
			 
% concentrico 2
	center_linha_conc2([ [ [e, e, e], [e, e, e], [e, e, r] ],
						[ [e, e, e], [e, e, e], [e, e, e] ],
						[ [e, e, e], [g, g, g], [e, e, e] ] ]).


%%%%% tabuleiros de empate

% TO-DO

% center_iguais_horiz1
% center_iguais_horiz2
% center_iguais_vert1
% center_iguais_vert2
% center_linha_cresc_hor1
% center_linha_cresc_hor2
% center_linha_cresc_diag1
% center_linha_cresc_diag2
% center_linha_conc1
% center_linha_conc2

coluna('A', 1).
coluna('B', 2).
coluna('C', 3).

teste_print:-
	left(L),
	center(C),
	top(T),
	right(R),
	bottom(B),
	nl,
	display(T, L, C, R, B), nl.

	
check_victory(Center, PieceLetter):-
	check_victory_horizontal(Center, PieceLetter);
	(
	transpose(Center, CenterTransp),
	check_victory_horizontal(CenterTransp, PieceLetter)
	);
	check_victory_concentric(Center,  PieceLetter);
	check_victory_diagonal(Center, PieceLetter).

	check_victory_horizontal([], PieceLetter):- fail.

check_victory_horizontal([Line|CenterR], PieceLetter):-
	(
	(Line = [[A, _, _], [A, _, _], [A, _, _]],
	PieceLetter = A);
	(Line = [[_, A, _], [_, A, _], [_, A, _]],
	PieceLetter = A);
	(Line = [[_, _, A], [_, _, A], [_, _, A]],
	PieceLetter = A);
	(Line = [[A, _, _], [_, A, _], [_, _, A]],
	PieceLetter = A);
	(Line = [[_, _, A], [_, A, _], [A, _, _]],
	PieceLetter = A)
	), PieceLetter \= 'e';
	check_victory_horizontal(CenterR, PieceLetter).
	

check_victory_diagonal(Center, PieceLetter):-
	(
	(Center = [[[A, _, _], [_, _, _], [_, _, _]],
				[[_, _, _], [A, _, _], [_, _, _]],
				[[_, _, _], [_, _, _], [A, _, _]]],
	PieceLetter = A);
	(Center = [[[_, A, _], [_, _, _], [_, _, _]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[_, _, _], [_, _, _], [_, A, _]]],
	PieceLetter = A);
	(Center = [[[_, _, A], [_, _, _], [_, _, _]],
				[[_, _, _], [_, _, A], [_, _, _]],
				[[_, _, _], [_, _, _], [_, _, A]]],
	PieceLetter = A);
	(Center = [[[A, _, _], [_, _, _], [_, _, _]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[_, _, _], [_, _, _], [_, _, A]]],
	PieceLetter = A);
	(Center = [[[_, _, A], [_, _, _], [_, _, _]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[_, _, _], [_, _, _], [A, _, _]]],
	PieceLetter = A);

		(Center = [[[_, _, _], [_, _, _], [A, _, _]],
				[[_, _, _], [A, _, _], [_, _, _]],
				[[A, _, _], [_, _, _], [_, _, _]]],
	PieceLetter = A);

	(Center = [[[_,_, _], [_, _, _], [_, A, _]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[_, A, _], [_, _, _], [_, _, _]]],
	PieceLetter = A);
	(Center = [[[_, _,_], [_, _, _], [_, _, A]],
				[[_, _, _], [_, _, A], [_, _, _]],
				[[_, _, A], [_, _, _], [_, _, _]]],
	PieceLetter = A);
	(Center = [[[_, _, _], [_, _, _], [_, _, A]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[A, _, _], [_, _, _], [_, _, _]]],
	PieceLetter = A);
	(Center = [[[_, _, _], [_, _, _], [A, _, _]],
				[[_, _, _], [_, A, _], [_, _, _]],
				[[_, _, A], [_, _, _], [_, _, _]]],
	PieceLetter = A)
	), PieceLetter \= 'e'.
	

check_victory_concentric([], PieceLetter):-fail.	
check_victory_concentric([Line|CenterR], PieceLetter):-
		check_victory_concentric_aux(Line, PieceLetter);
		check_victory_concentric(CenterR, PieceLetter).

check_victory_concentric_aux([], PieceLetter):- fail.
check_victory_concentric_aux([Position|Rest], PieceLetter):-
		(Position = [A, A, A],
		PieceLetter = A,
		PieceLetter \= 'e');
	   check_victory_concentric_aux(Rest, PieceLetter).


