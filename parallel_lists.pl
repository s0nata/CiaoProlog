:- module(parallel_lists,[main/0],[]).

% this module illustrates two alternatives for mapping a list
% to another one (list of numerical value duplicates in this case)

main :-
        Inp = [1,2,3,4],
        list_doubles1(Inp, LDs1),
        list_doubles2(Inp, LDs2),
        display('input  : '), display(Inp), nl,
        display('output1: '), display(LDs1), nl,
        display('output2: '), display(LDs2), nl.

% ----------------------------------------------------------------------
% requires an additional 'accumulator argument'
% result is in the reversed order

list_doubles1(L, LD) :-
        list_doubles_(L, [], LD).

list_doubles_([]    , LD,  LD).
list_doubles_([N|Ns], Acc, LD) :-
        double(N, N2),
        list_doubles_(Ns, [N2|Acc], LD).

% ----------------------------------------------------------------------
% does not require an additional storage
% result is in the same order


list_doubles2([]    , []).
list_doubles2([N|Ns], LD) :-
        double(N, N2),
        LD = [N2 | LD_new],
        list_doubles2(Ns, LD_new).

% ----------------------------------------------------------------------

double(N, N2) :- N2 is N * 2.