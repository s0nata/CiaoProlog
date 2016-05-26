:- module(flag_demo,[main/1],[]).

% this module demonstrates use of data predicates as flags
% and failure-driven loops

% ----------------------------------------------------------------------

:- data mydata/1.      % regular data predicate
:- data skip_before/1. % flag with 1 parameter
:- data myflag/0.      % 'boolean' flag


% returns values of the mydata/1 predicate in the order they are stored
% and only those that appear after an instance stored in the skip_before/1
% predicate

get_data(D) :-
        (\+ skip_before(_)), !,
         mydata(D).
get_data(D) :-
        retractall_fact(myflag),
        mydata(D0),
        ( skip_before(D0)
        -> asserta_fact(myflag), fail
        ; true),
        myflag,
        D = D0.

% ----------------------------------------------------------------------

% assert test data to the memory
prepare_data :-
        assertz_fact(mydata(8)),
        assertz_fact(mydata(3)),
        assertz_fact(mydata(5)),
        assertz_fact(mydata(1)),
        assertz_fact(mydata(2)),
        assertz_fact(mydata(7)),
        assertz_fact(mydata(4)),
        assertz_fact(mydata(6)).

% retract test data from the memory
clean_data :-
        retractall_fact(mydata(_)),
        retractall_fact(skip_before(_)),
        retractall_fact(myflag).

% failure-driven printer loop
print_data :-
        get_data(N),
        display(N), nl,
        fail.
print_data.

% some goals to execute in the toplevel:
% ?- main(7).
% ?- main(5).

main(N) :-
        prepare_data,
        asserta_fact(skip_before(N)),
        print_data,
        clean_data.