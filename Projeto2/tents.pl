:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-set_prolog_flag(toplevel_print_options, [quoted(true),portrayed(true),max_depth(0)]).
:- dynamic  cell/3, vazio/2. 



palmeira(3, 1).
palmeira(3, 4).
palmeira(3, 6).



line(3, 3).
col(-1,-1).

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

line(1, 3).
line(6, 2).
*/

%__________________Variaveis2_________________________________
/*
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

*/
%_________________________________________________________________

% tents: predicado principal
% para um tabuleiro 6x6, utilizar tents(6).

tents(N):-
    Lenght is N+1, % length fica N + 1 para facilitar utilização de nth
    init([], 1, 1, Lenght, 1, VarsEnd),
    domain(VarsEnd, 0,1),
    restrit(1,Lenght,VarsEnd),
    nTents(VarsEnd),
    tents2x2(2, Lenght, VarsEnd),nl,
    palmeiraAdj(VarsEnd),
    labeling([],VarsEnd ),
    showBoard(Lenght, VarsEnd),
    showResult(1, Lenght, VarsEnd).

% notTent:
% V = 0 se não tiver palmeira adjacente; V=1 se tiver

notTent(L,C, V):-
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


% ------- INICIALICAÇÃO -------

init(Vars, N, _, N, _, VarsEnd):- VarsEnd = Vars.
 
init(Vars,L , N, N, I, VarsEnd):-
    NewLine is L + 1,
    init(Vars, NewLine, 1, N, I, VarsEnd).

% init(Vars, Linha, Coluna, DimensãoMatriz, Index, VarsEnd)
% LAZ explica sff o que fazemos ao certo com o Vars e o VarsEnd
%vars---variaveis nao inicializadas,
%varEnd--resultado das variaveis nao inicializadas, é onde vamos aplicar as restriçoes nesta variaveis
init(Vars, L, C, N, Index, VarsEnd):-
	% se não é palmeira e se não tem tenda
    (\+ (palmeira(L,C)), notTent(L, C, V),
        ((V==0, assert(vazio(L,C)),NewC is C + 1, init(Vars, L, NewC, N, Index, VarsEnd));
        (assert(cell(Index, L,C)), 
        NewIndex is Index + 1,
        NewC is C + 1, 
        init([_|Vars], L, NewC, N, NewIndex, VarsEnd))));
    % se é palmeira ou tenda
        (NewC is C + 1,
        init(Vars, L, NewC, N, Index, VarsEnd)).
        
% restrit:	calcula o número de tendas por linha e por coluna
% I vai de 1 até N+1
% I vai buscar o valor que foi declarado na posição em questão
% guarda tudo em listas e soma os valores

restrit(N, N, _).
restrit(I, N, Vars):-
    ((line(I, VLine), findall(Index, cell(Index, I,_),ListLine), sumVars(ListLine,Vars,VLine,[]),
      col(I, VCol), findall(Index, cell(Index, _,I), ListCol), sumVars(ListCol, Vars,VCol,[]));
     (col(I, VCol), findall(Index, cell(Index, _,I), ListCol),  sumVars(ListCol, Vars,VCol,[]));
     (line(I, VLine), findall(Index, cell(Index, I,_),ListLine), sumVars(ListLine,Vars,VLine,[]));
	 % write em branco no caso de não haver valor indicado p/ total de linha ou coluna
     write('')),
    NewI is I +1,
    restrit(NewI, N, Vars).

% sumVars: soma os  valores, resultado em VLine

sumVars([],_,VLine,ListLine):-
    sum(ListLine, #=, VLine).

sumVars([E|List],Vars, VLine,ListLine):-
    nth1(E,Vars, Value),
    sumVars(List,Vars, VLine,[Value|ListLine]).

	
% nTents
% encontra o número de tendas

nTents(Vars):-
    findall(A,palmeira(A,_),List), % encontra as palmeiras todas
    length(List, L), % obtém o comprimento
    sum(Vars, #=, L). % soma os valores (com tenda=1, sem tenda = 0)

%___________________________________________________________________


% tents2x2: verifica se não há mais tendas no quadrado adjacente
tents2x2(Lenght, Lenght, _).
tents2x2(Li, Lenght, Vars):-
    tents2x2Aux(Li, 2, Lenght, Vars),
    NewLine is Li +1,
    tents2x2(NewLine, Lenght, Vars).

tents2x2Aux(_, Lenght, Lenght, _).
tents2x2Aux(L,C, Lenght, Vars):-
    Nort is L- 1,
    West is C - 1,
    (
	  % cell encontra índice do que está na posição
	  % value vai ser zero se o espaço estiver vazio
	  % verifica as 4 coordenadas adjacentes (vertical e horizontal)
	  % LAZ nós com isto vemos norte, sul, este, oeste, e nordeste, noroeste, etc?
	  % LAZ não devíamos ter 8 'cell' ?
      %eu verifico que em cada quadrado de dois por dois apenas pode ter uma tenda, deste modo vamos fazer isso recursivamente
      %para cada linha e coluna
      ((cell(Index1, L,C),    nth1(Index1,Vars, Value1)); Value1=0),
      ((cell(Index2, Nort,C), nth1(Index2,Vars, Value2)); Value2=0),
      ((cell(Index3, L,West), nth1(Index3,Vars, Value3)); Value3=0),
      ((cell(Index4, Nort,West), nth1(Index4,Vars, Value4)); Value4=0)
     ),
	 % valor máximo é 1 -> máximo de 1 tenda
     sum([Value1, Value2, Value3, Value4],#=<,1),
     Next is C+1,
     tents2x2Aux(L,Next, Lenght, Vars).

% palmeiraAdj:
% à volta duma palmeira, tem de haver no mínimo uma tenda
% procuramos as palmeiras todas e inserimos numa lista
% LAZ explica o resto sff, não apontei muito bem (do palmeiraAdjAux
%recebe como parametro as palmeiras do board e as variaveis
%verifica que tem que ter no minimo uma tenda ao lado dessa palmeira em especifico

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
	% se não for encontrada uma tenda, o valor será zero
	% soma >= 1 -> pelo menos uma tenda
    sum([Value1, Value2, Value3, Value4],#>=,1),
    palmeiraAdjAux(Palmeiras,Vars).

% LAZ aqui é só para confirmar se o número de tendas bate certo com o valor declarado ao fim da linha?----
%isto é para depois vermos o numero de casa sem tendas numa determinada linha, uso isto para aqueles numero que aparecem em baixo da solução do board
% LAZ se sim, onde fazemos para a coluna?
%quem faz isso é a função  restrit

tentsLine(Vars, [], ListEnd, ListEnd).
tentsLine(Vars,[[E-Col]|Indexs],List, ListEnd):-
    nth1(E, Vars, Value),
    ((Value = 1, tentsLine(Vars, Indexs, [Col|List], ListEnd));
    tentsLine(Vars, Indexs, List, ListEnd)).



/***************************************************************/

% showResult: apresenta a answer key
% the maximum continuous non-tent area for each row, from top to bottom. In case of double digit numbers, enter the right (unit) digit only.
showResult(Lenght, Lenght, _).

showResult(Line, Lenght, Vars):-
    findall([Index-Col], Line^cell(Index, Line,Col), List),
    tentsLine(Vars,List,[], ListEnd),

    reverse(ListEnd, Cols),
    showResultAux(0, Lenght, Cols, -1),
    NewLine is Line +1,
    showResult(NewLine, Lenght, Vars).

% E é o primeiro elem. da lista (com tendas de cada linha)
% vemos se cada elemento é maior do que -1, se for guardamos
% para cada linha
% write do resultado quando a lista é vazia
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
% ------- WRITES -------

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
