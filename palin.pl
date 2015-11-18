:- module(palin,has_palindrome_permutation/1,[]).

% Program that checks whether any permutation of an input
% string Word (here a Prolog atom) is a palindrome.

% Examples:
% ?- has_palindrome_permutation('madma').
% yes
% ?- has_palindrome_permutation('madman').
% no

:- use_module(library(dict),
        [
            dic_replace/4,
            dic_lookup/4,
            dic_node/2
        ]).
:- use_module(library(lists),[length/2]).
:- use_module(library(aggregates),[findall/3]).

has_palindrome_permutation(Word) :-
        word_to_dict(Word,_,Dict),
        palin_check_dict(Dict).

word_to_dict('', Dict, Dict) :- !.
word_to_dict(Word0,Dict0,Dict) :-
        sub_atom(Word0,0,1,Char),
        check_char_in_dict(Char,Dict0,Dict1),
        atom_concat(Char,Word1,Word0),
        word_to_dict(Word1,Dict1,Dict).

check_char_in_dict(Char,Dict,Dict) :-
        dic_lookup(Dict,Char,1,new), !.
check_char_in_dict(Char,Dict0,Dict1) :-
        dic_lookup(Dict0,Char,Parity,old),
        FlipParity is rem(Parity + 1, 2),
        dic_replace(Dict0,Char,FlipParity,Dict1).

% Note: using findall/3 is not optimal.
palin_check_dict(Dict) :-
        findall(Char,dic_node(Dict,dic(Char,1,_,_)),Chars),
        length(Chars,OddCharsNumber),
        OddCharsNumber =< 1.
