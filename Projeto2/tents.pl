:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-set_prolog_flag(toplevel_print_options, [quoted(true),portrayed(true),max_depth(0)]).

palmeira(Line,Col).
tenda(Line,Col).
col(Col,Value).
line(Line, Value).


tents(TabEnd, N):-
    geraTab(0 ,N, [], TabEnd),
    tree(Tree),
    init(TabEnd, Tree),
    domain(TabEnd, 0,1)


geraTab(N, N, Tab,TabEnd):-TabEnd = Tab.
geraTab(Index, N, Tab, TabEnd):-
    length(Line, N),
    NewIndex is Index+1,
    geraTab(NewIndex, N, [Line|Tab], TabEnd).

init(_, []).
init(TabEnd, [T|Tree]):-
    T = date(L, C, V),
    nth1(L, TabEnd, Line),
    nth1(C, Line, Elemen),
    Elemen = V,
    init(TabEnd, Tree).















    




