%palmeira(Line,Col).
%tenda(Line,Col).
%col(Col,Value).
%line(Line, Value).


palmeira(1,2).
palmeira(2,4).
palmeira(3,2).
palmeira(4,4).
palmeira(4,6).
palmeira(5,1).
palmeira(5,2).
palmeira(6,4).

tenda(1,1).

col(1,3).
col(6,1).

line(1,2).
line(6,2).

% board(linhas, colunas)
board(6,6).

showBoard :-
	board(Lines,Columns),
	showBoardAux(Lines, Columns, 1, 1).
	
showBoardAux(L, C, Li, Ci):-
	Li =< L,
	Ci =< C,
	showChar(Li, Ci),
	CiNew is Ci + 1,
	%(CiNew = C, CiNew2 is 1, LiNew is Li + 1,
	%showBoardAux(L, C, LiNew, CiNew2));
	showBoardAux(L, C, Li, CiNew).
	
showChar(Li, Ci):-	
	palmeira(Li, Ci), write('P'), write(' | ');
	tenda(Li,Ci), write('T'), write(' | ');
	write('_'), write(' | ').
	
	
