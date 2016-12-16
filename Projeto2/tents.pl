:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-set_prolog_flag(toplevel_print_options, [quoted(true),portrayed(true),max_depth(0)]).
:- dynamic  cell/3, vazio/2. 

%__________________Variaveis1_________________________________
/*
palmeira(1, 2).
palmeira(2, 4).
palmeira(3, 2).
palmeira(4, 4).
palmeira(4, 6).
palmeira(5, 1).
palmeira(5, 2).
palmeira(6, 4).

col(1, 3).
col(6, 1).

line(1, 2).
line(6, 2).
*/
%__________________Variaveis2_________________________________
palmeira(1, 3).
palmeira(1, 6).
palmeira(2, 1).
palmeira(3, 2).
palmeira(3, 5).
palmeira(5, 4).
palmeira(6, 1).
palmeira(6, 4).
palmeira(7, 7).

col(1, 1).
col(2, 2).
col(3, 1).
col(4, 2).
col(5, 1).
col(6, 1).
col(7, 1).

line(1, 2).
line(2, 1).
line(3, 1).
line(4, 1).
line(5, 1).
line(6, 1).
line(7, 2).
%_________________________________________________________________
tents(N):-
    Lenght is N+1,
    init([], 1, 1, Lenght, 1, VarsEnd),
    domain(VarsEnd, 0,1),
    restrit(1,Lenght,VarsEnd),
    nTends(VarsEnd),
    tends2x2(2, Lenght, VarsEnd),nl,
    palmeiraAdj(VarsEnd),
    labeling([],VarsEnd ),
    showBoard(Lenght, VarsEnd),
    showResult(1, Lenght, VarsEnd).

notTend(L,C, V):-
    Nort is L-1,
    South is L+1,
    Easth is C+1,
    West is C-1,
    ((palmeira(Nort, C);
    palmeira(South, C);
    palmeira(L, Easth);
    palmeira(L, West)),
    V is 1);
    V is 0.

init(Vars, N, _, N, _, VarsEnd):- VarsEnd = Vars.
 
init(Vars,L , N, N, I, VarsEnd):-
    NewLine is L + 1,
    init(Vars, NewLine, 1, N, I, VarsEnd).


init(Vars, L, C, N, Index, VarsEnd):-
    (\+ (palmeira(L,C)), notTend(L, C, V),
        ((V==0, assert(vazio(L,C)),NewC is C + 1, init(Vars, L, NewC, N, Index, VarsEnd));
        (assert(cell(Index, L,C)), 
        NewIndex is Index + 1,
        NewC is C + 1, 
        init([_|Vars], L, NewC, N, NewIndex, VarsEnd))));
        
        (NewC is C + 1,
        init(Vars, L, NewC, N, Index, VarsEnd)).
        
restrit(N, N, _).
restrit(I, N, Vars):-
    ((line(I, VLine), findall(Index, cell(Index, I,_),ListLine), sumVars(ListLine,Vars,VLine,[]),
      col(I, VCol), findall(Index, cell(Index, _,I), ListCol), sumVars(ListCol, Vars,VCol,[]));
     (col(I, VCol), findall(Index, cell(Index, _,I), ListCol),  sumVars(ListCol, Vars,VCol,[]));
     (line(I, VLine), findall(Index, cell(Index, I,_),ListLine), sumVars(ListLine,Vars,VLine,[]));
     write('')),
    NewI is I +1,
    restrit(NewI, N, Vars).

sumVars([],_,VLine,ListLine):-
    sum(ListLine, #=, VLine).

sumVars([E|List],Vars, VLine,ListLine):-
    nth1(E,Vars, Value),
    sumVars(List,Vars, VLine,[Value|ListLine]).

nTends(Vars):-
    findall(A,palmeira(A,_),List),
    length(List, L),
    sum(Vars, #=, L).

%___________________________________________________________________
tends2x2(Lenght, Lenght, _).
tends2x2(Li, Lenght, Vars):-
    tends2x2Aux(Li, 2, Lenght, Vars),
    NewLine is Li +1,
    tends2x2(NewLine, Lenght, Vars).


tends2x2Aux(_, Lenght, Lenght, _).
tends2x2Aux(L,C, Lenght, Vars):-
    Nort is L- 1,
    West is C - 1,
    (
      ((cell(Index1, L,C),    nth1(Index1,Vars, Value1)); Value1=0),
      ((cell(Index2, Nort,C), nth1(Index2,Vars, Value2)); Value2=0),
      ((cell(Index3, L,West), nth1(Index3,Vars, Value3)); Value3=0),
      ((cell(Index4, Nort,West), nth1(Index4,Vars, Value4)); Value4=0)
     ),
     sum([Value1, Value2, Value3, Value4],#=<,1),
     Next is C+1,
     tends2x2Aux(L,Next, Lenght, Vars).


palmeiraAdj(Vars):-
    findall([L-C], palmeira(L,C), Palmeiras),
    palmeiraAdjAux(Palmeiras,Vars).

palmeiraAdjAux([],_).
palmeiraAdjAux([[L-C]|Palmeiras],Vars):-

    Nort is L-1,
    South is L+1,
    West is C-1,
    Easth is C+1,
        (
      ((cell(Index1, Nort,C),   nth1(Index1,Vars, Value1)); Value1=0),
      ((cell(Index2, South,C), nth1(Index2,Vars, Value2)); Value2=0),
      ((cell(Index3, L,Easth), nth1(Index3,Vars, Value3)); Value3=0),
      ((cell(Index4, L,West), nth1(Index4,Vars, Value4)); Value4=0)
     ),
    sum([Value1, Value2, Value3, Value4],#>=,1),
    palmeiraAdjAux(Palmeiras,Vars).


tendsLine(Vars, [], ListEnd, ListEnd).
tendsLine(Vars,[[E-Col]|Indexs],List, ListEnd):-
    nth1(E, Vars, Value),
    ((Value = 1, tendsLine(Vars, Indexs, [Col|List], ListEnd));
    tendsLine(Vars, Indexs, List, ListEnd)).



/***************************************************************/
showResult(Lenght, Lenght, _).

showResult(Line, Lenght, Vars):-
    findall([Index-Col], Line^cell(Index, Line,Col), List),
    tendsLine(Vars,List,[], ListEnd),

    reverse(ListEnd, Cols),
    showResultAux(0, Lenght, Cols, -1),
    NewLine is Line +1,
    showResult(NewLine, Lenght, Vars).

/***************************************************************/
showResultAux(E, Lenght, [], Maior):-
    Value is Lenght - E,
    (
     (Value > Maior, Result is Value -1, write(Result)); 
     Result is Maior -1, write(Result)).

showResultAux(Index, Lenght, [E|List], Maior):-
    Value is E-Index,
    ((Value > Maior, showResultAux(E, Lenght, List, Value));
    showResultAux(E, Lenght, List, Maior)).

/***************************************************************/
line(1).
line(L):-
    Line is L-1,
    write('----'),
    line(Line).

lineValue(L, L).
lineValue(I, L):-
    ((col(I, V), format('  ~w ',[V])); 
     format('    ',[])),
     C is I+1,
    lineValue(C, L).

showBoard(L, Vars):- 
    line(L),nl,
	showBoardLine(1, L, Vars),
    line(L),nl,
    lineValue(1,L),nl,nl.

showBoardLine(L, L, _).


showBoardLine(Li, L,Vars):-
     write('| '),
	showBoardCol(Li, 1, L, Vars),nl,
	LiNew is Li+1,
	showBoardLine(LiNew, L,Vars).

showBoardCol(L, C, C, _):- ((line(L, V), write(V)); write('')).
showBoardCol(L, Ci, C, Vars):-
	showChar(L, Ci, Vars),
	CiNew is Ci + 1,
	showBoardCol(L,CiNew, C, Vars).
	
showChar(Li, Ci, Vars):-	
	((palmeira(Li, Ci), write('P'), write(' | '));
	 (cell(Index, Li,Ci), nth1(Index, Vars, Value), 
     (Value==1, write('T'); write('-')), write(' | '));
	 (vazio(Li,Ci), write('-'), write(' | '))).
