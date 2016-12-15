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



tents(TabEnd, N):-
    Lenght is N+1,
    init([], 1, 1, Lenght, 1, VarsEnd),
    domain(VarsEnd, 0,1),
    restrit(1,Lenght,VarsEnd),
    labeling([],VarsEnd ),
    format('~n ~w ~n', [VarsEnd]).



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
        init([Value|Vars], L, NewC, N, NewIndex, VarsEnd))));
        
        (NewC is C + 1,
        init(Vars, L, NewC, N, Index, VarsEnd)).
        
restrit(N, N, _).
restrit(I, N, Vars):-
    ((line(I, VLine), findall(Index, cell(Index, I,_),ListLine), sumVars(ListLine,Vars,VLine,[]),
      col(I, VCol), findall(Index, cell(Index, _,I), ListCol),format('~w ~n', [ListCol]),  sumVars(ListCol, Vars,VCol,[]));

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

npalmeiras:-
    aggregate_all(count, palmeira(L,C), A),
    write(A).

