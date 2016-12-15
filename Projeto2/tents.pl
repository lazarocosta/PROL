:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(aggregate)).
:-set_prolog_flag(toplevel_print_options, [quoted(true),portrayed(true),max_depth(0)]).
:- dynamic  cell/3, vazio/2. 


palmeira(1,2).
palmeira(2,4).
palmeira(3,2).
palmeira(4,4).
palmeira(4,6).
palmeira(5,1).
palmeira(5,2).
palmeira(6,4).

col(1,3).
col(6,1).

line(1, 2).
line(6, 2).

vazio(-1, -1).



tents(VarsEnd, N):-
    Lenght is N+1,
    init([], 1, 1, Lenght, 1, VarsEnd),
    domain(VarsEnd, 0,1),
    restrit(1,Lenght,VarsEnd),
    nTends(VarsEnd),
    tends2x2(2, Lenght, VarsEnd),nl,
    palmeiraAdj(VarsEnd),
    labeling([],VarsEnd ),
    showBoard(Lenght, VarsEnd).



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
           %format('~w:  ~w:  ~w  ~n', [L,C,N]),
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
    format('~w ~n',[Palmeiras]),
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

/***************************************************************/
showBoard(L, Vars):-
	showBoardLine(1, L, Vars).

showBoardLine(L, L, _).
showBoardLine(Li, L,Vars):-
	showBoardCol(Li, 1, L, Vars),nl,
	LiNew is Li+1,
	showBoardLine(LiNew, L,Vars).

showBoardCol(_, C, C, _).

showBoardCol(L, Ci, C, Vars):-
	showChar(L, Ci, Vars),
	CiNew is Ci + 1,
	showBoardCol(L,CiNew, C, Vars).
	
showChar(Li, Ci, Vars):-	
	((palmeira(Li, Ci), write('P'), write(' | '));
	(cell(Index, Li,Ci), nth1(Index, Vars, Value), (Value==1, write('T'); write('-')), write(' | '));
	(vazio(Li,Ci), write('-'), write(' | '))).


