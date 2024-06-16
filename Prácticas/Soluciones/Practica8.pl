%ejercicio1

%base de conocimento que me dan
padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

% 1) juan
hijo(X,Y) :- padre(Y,X).
hermano(X,Y) :- padre(Z,X), padre(Z,Y), X \= Y.
decendiente(X,Y) :- padre(Y,Z), padre(Z,X).