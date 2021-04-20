phonecompany(sumsum).
phonecompany(appy).

competitor(sumsum,appy).
competitor(appy,sumsum).

product(galactica-s3).

develop(sumsum, galactica-s3).

boss(stevey).

steal(stevey, galactica-s3).

rival(X, appy):- competitor(X, appy).

unethical(A):-
    boss(A),
    product(X),
    phonecompany(Y),
    develop(Y,X),
    rival(Y, appy),
    steal(A, X).



