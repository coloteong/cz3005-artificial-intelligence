offspring(male, charles).
offspring(female, ann).
offspring(male, andrew).
offspring(male, edward).

older_sibling(charles, ann).
older_sibling(ann, andrew).
older_sibling(andrew, edward).

older(X,Z):-
    older_sibling(X,Y);
    older_sibling(Y,Z);
    older_sibling(X,Z).

succession(X,Y):-
    offspring(male, X), offspring(female, Y);
    offspring(male, X), offspring(male, Y), older(X,Y);
    offspring(female, X), offspring(female, Y), older(X,Y).



