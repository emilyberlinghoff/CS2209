% ===== Facts =====

% parent(Parent, Child)
parent(sue, rob).
parent(sue, estelle).
parent(john1, rob).
parent(john1, estelle).

parent(ida, george).
parent(peter, george).
parent(ida, grace).
parent(peter, grace).

parent(estelle, john2).
parent(estelle, mary).
parent(estelle, jay).
parent(george, john2).
parent(george, mary).
parent(george, jay).

% gender
female(sue).
female(ida).
female(estelle).
female(grace).
female(mary).

male(john1).
male(john2).
male(peter).
male(rob).
male(george).
male(jay).

spouse(estelle, george).
spouse(george, estelle).

% ===== Rules =====

% grandparent(X, Y): X is a grandparent of Y
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% grandfather(X, Y): X is a grandfather of Y
grandfather(X, Y) :- male(X), grandparent(X, Y).

% ancestor(X, Y): X is an ancestor of Y
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% sibling(X, Y): X and Y are siblings (share a parent)
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% brother(X, Y): X is a male sibling of Y
brother(X, Y) :- male(X), sibling(X, Y).

% a_pair_of_brother(X, Y): unordered pair of brothers (both male)
a_pair_of_brother(X, Y) :-
    male(X), male(Y),
    sibling(X, Y),
    X @< Y.

% uncle(X, Y): X is an uncle of Y
uncle(X, Y) :- male(X), parent(Z, Y), sibling(X, Z).

% mother_in_law(X, Y): X is mother-in-law of Y
mother_in_law(X, Y) :- female(X), parent(X, Z), spouse(Z, Y).
mother_in_law(X, Y) :- female(X), parent(X, Z), spouse(Y, Z).