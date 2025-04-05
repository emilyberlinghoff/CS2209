% ==================================================== QUESTION 1 ====================================================
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

% ==================================================== QUESTION 2 ====================================================
% ===== US and Canadian Cities =====
city(chicago).
city(toronto).
city(detroit).
city(orlando).
city(newyork).
city(losangeles).

% ===== WWII Hero Keywords (short names that can match in airport names) =====
wwii_hero("O'Hare").
wwii_hero("MacArthur").
wwii_hero("Eisenhower").
wwii_hero("Patton").

% ===== WWII Battle Keywords =====
wwii_battle("Midway").
wwii_battle("Normandy").
wwii_battle("Bulge").
wwii_battle("Iwo").

% ===== Airport Names by City =====
airport(chicago, "O'Hare International Airport").
airport(chicago, "Midway Airport").

airport(toronto, "Pearson International Airport").
airport(toronto, "Billy Bishop Airport").

airport(detroit, "Wayne County Airport").
airport(orlando, "Orlando International Airport").
airport(newyork, "John F. Kennedy International Airport").
airport(newyork, "LaGuardia Airport").
airport(losangeles, "Los Angeles International Airport").

% ===== Matching logic =====
named_for_hero(Name) :-
    wwii_hero(Hero),
    sub_atom(Name, _, _, _, Hero).

named_for_battle(Name) :-
    wwii_battle(Battle),
    sub_atom(Name, _, _, _, Battle).

% ===== Clue resolution rule =====
query(City) :-
    city(City),
    airport(City, A1),
    airport(City, A2),
    A1 \= A2,
    (
        (named_for_hero(A1), named_for_battle(A2));
        (named_for_battle(A1), named_for_hero(A2))
    ).

% ==================================================== QUESTION 3 ====================================================
% ===== last =====
% base case: the last element of a single-element list is that element
my_last(X, [X]).

% recursive case: keep moving through the list until you reach the last element
my_last(X, [_|T]) :- my_last(X, T).

% ===== adjacent =====
% base case: X and Y are adjacent if they appear at the head of the list
adjacent(X, Y, [X,Y|_]).

% recursive case: skip head and check the rest of the list
adjacent(X, Y, [_|T]) :- adjacent(X, Y, T).
