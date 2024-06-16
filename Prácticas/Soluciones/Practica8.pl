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

%  1) juan
%) 2)
hijo(X,Y) :- padre(Y,X).

hermano(X,Y) :- padre(Z,X), padre(Z,Y), X \= Y.

descendiente(X,Y) :- padre(Y,X).
descendiente(X,Y) :- padre(Y,Z), descendiente(X,Z).

% 3) lo hice en el cuaderno
% 4) abuelo(juan,X).
% 5) hermano(X,pablo).
% 6)

%ancestro(X, X).
%ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% 7) este nuevo hecho y regla lo leo como x es ancestro de y, si consultamos ancestro(juan,X). nos devuelve x = juan, debido al primer hecho
% si le pedimos mas resultados nos devuelve los decendientes de juan.

% 8) para arreglar esto eliminaria el hecho, ancestro(X, X). pues x no es ancestro de si mismo, lo cambiaria por esto:

ancestro(X, Y) :- padre(X,Y).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% ejercicio 3
%base de conocimento que me dan
natural(0).
natural(suc(X)) :- natural(X).

%menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
%menorOIgual(X,X) :- natural(X).

% 1) se cuelga, debido a que en nuestra definicion de naturales no existe numeros menores a cero.

% 2)
/* 
un programa puede congarse si:
- no defino el caso base de la recursion
- no ordeno bien las clausulas
- si no difino bien la unificacion, osea si tengo una clausula la cual se puede unificar con si misma o con otra infinitamente debido a
variables no restringidas
*/

% 3) aca lo que esta mal es el orden de las clausulas
menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

% 4) Definir el predicado juntar(?Lista1,?Lista2,?Lista3), que tiene éxito si Lista3 es la concatenación de Lista1 y Lista2. Por ejemplo:

juntar([], Lista2, Lista2).
juntar([X | Lista1],Lista2, [X | Lista3]) :- juntar(Lista1,Lista2,Lista3).

% ejercicio 5

% 1) last(?L, ?U), donde U es el último elemento de la lista L.

last([X],X).
last([_ | XS], N) :- last(XS,N).
% no se me ocuure con append.

% 2) reverse(+L, -L1), donde L1 contiene los mismos elementos que L, pero en orden inverso.

reverse([],[]).
reverse([X | XS], L) :- reverse(XS,YS), append(YS,[X],L).

% 3) prefijo(?P, +L), donde P es prefijo de la lista L.
prefijo(L,S) :- append(L,_,S).

% 4) sufijo(?S, +L), donde S es sufijo de la lista L
sufijo(S,L) :- append(L,_,S).

% 5) sublista(?S, +L), donde S es sublista de L

