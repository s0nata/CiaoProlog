:- module(fib,[fib/2, test/0],[]).

% compute N-th fibonacci number in O(N) time, O(1) space

:- use_module(library(hiordlib), [map/3]).

fib(N,  _) :- N < 0, !, message(error, 'Invalid argument 1 (less than zero).').
fib(0,  0).
fib(1,  1).
fib(N, Fn) :-
        fib_(0,1,1,N,Fn).

fib_(CR2,CN1,CR1,N,R) :-
        N is CN1 + 1,!,
        R is CR2 + CR1.
fib_(CR2,CN1,CR1,N,R) :-
        CN is CN1 + 1,
        CR is CR2 + CR1,
        fib_(CR1,CN,CR,N,R).

fib_testtable(0,0).
fib_testtable(1,1).
fib_testtable(2,1).
fib_testtable(3,2).
fib_testtable(4,3).

test :-
        Input = [0, 1, 2, 3, 4],
        map(Input, fib_testtable, ResTrue),
        map(Input, fib          , Res),
        (ResTrue == Res
        -> display('| test OK'),nl
        ;  display('| test FAIL'),nl,
           display_list(['| Res     = ', Res]),nl,
           display_list(['| ResTrue = ', ResTrue]),nl
        ).
