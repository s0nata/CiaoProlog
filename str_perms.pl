:- module(str_perms, [perm/2], []).

:- use_module(library(lists),[append/3]).

% Given a list of UNIQUE atomic characters, produces a set of all
% possible permutations of the elements of the initial lists.
%
% TODO: Not optimized w.r.t time/space costs.
% TODO: Not optimized uses of append/3.

perm(ListIn, LListOut) :-
        perm_(ListIn, [], LListOut).

perm_([], LListOut, LListOut).
perm_([CurEl|Rest], CurPerms, LListOut) :-
        sub_perm(CurPerms, CurEl, [], NewPerms),
        perm_(Rest, NewPerms, LListOut).

sub_perm([], Char, [], [[Char]]) :- !.
sub_perm([], _, LListOut, LListOut).
sub_perm([Word | Words], Char, Acc, LListOut) :-
        ins(Char, Word, WordDerivs),
        append(WordDerivs, Acc, Acc1),
        sub_perm(Words, Char, Acc1, LListOut).

ins(Ch, Word, WordList) :-
        ins_(Word, [], Ch, [], WordList).

ins_([] , Pref, Ch, Acc, [NewWord | Acc]) :-
        append(Pref, [Ch], NewWord).
ins_(Suf, Pref, Ch, Acc     , WordList) :-
        append(Pref, [Ch|Suf], NewWord),
        Suf = [Suf1 | NewSuf],
        append(Pref, [Suf1], NewPref),
        ins_(NewSuf, NewPref, Ch, [NewWord | Acc], WordList).