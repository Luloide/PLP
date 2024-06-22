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
last(L,X) :- append(_,[X],L).

% 2) reverse(+L, -L1), donde L1 contiene los mismos elementos que L, pero en orden inverso.
reverse([],[]).
reverse([X | XS], L) :- reverse(XS,YS), append(YS,[X],L).

% 3) prefijo(?P, +L), donde P es prefijo de la lista L.
prefijo(L,S) :- append(L,_,S).

% 4) sufijo(?S, +L), donde S es sufijo de la lista L
sufijo(S,L) :- append(L,_,S).

% 5) sublista(?S, +L), donde S es sublista de L
sublista(S,L) :- append(_,L2,L), append(S,_,L2).

% 6) pertenece(?X, +L), que es verdadero si el elemento X se encuentra en la lista L. (Este predicado ya viene definido en Prolog y se llama member).
pertenece(X,L):- append(_,[X | _],L).

% Ejercicio 6
/*
Definir el predicado aplanar(+Xs, -Ys), que es verdadero sii Ys contiene los elementos de todos los niveles de
Xs, en el mismo orden de aparición. Los elementos de Xs son enteros, átomos o nuevamente listas, de modo que
Xs puede tener una profundidad arbitraria. Por el contrario, Ys es una lista de un solo nivel de profundidad.
*/

/*
pensando los casos:
caso base: si la Xs es vacia entonces Ys debe ser vacia

Xs es una lista [X |XS]:
- si X es un elemento y no una lista, lo agrego a YS
- si X es una lista
    - si su primer elemento no es una lista entonces agregarlo a YS
    - si su primer elemento es una lista deberia aplanarlo, aplanar XS y juntar el resultado
*/
aplanar([], []).
aplanar([[] | XS], L) :- aplanar(XS, L).
aplanar([X | XS], L) :- is_list(X), aplanar(X, L2), aplanar(XS, L3), append(L2, L3, L). % Si X es una lista.
aplanar([X | XS], [X | L]) :- not(is_list(X)), aplanar(XS, L). % Si X no es una lista.

% Ejercicio 8
/*
1)  intersección(+L1, +L2, -L3), tal que L3 es la intersección sin repeticiones de las listas L1 y L2, respetando en L3 el orden en que aparecen los elementos en L1.
partir(N, L, L1, L2), donde L1 tiene los N primeros elementos de L, y L2 el resto. Si L tiene menos de N
elementos el predicado debe fallar. ¿Cuán reversible es este predicado? Es decir, ¿qué parámetros pueden
estar indefinidos al momento de la invocación?
*/
intersección([],_,[]). % si L1 es vacia entonces no hay interseccion
intersección([X|XS], L2, L3):- not(member(X,L2)), intersección(XS,L2,L3). % si X no pertence a L2, continuo
intersección([X|XS], L2, [X|L3]):- member(X,L2), sacar(X,L2,Lnueva), intersección(XS, Lnueva,L3). % si X pertenece L2, saco los X de L2 y continuo.

% saca el elemento X de una lista L
sacar(_,[],[]).
sacar(X,[Y|L], [Y|L3]) :- X \= Y, sacar(X,L,L3).
sacar(X,[X|L], L3) :- sacar(X,L,L3).

partir(0, L, [], L).
partir(N,[X|XS],[X|L1],L2) :-  N1 is N - 1, partir(N1,XS,L1,L2).

% 2) borrar(+ListaOriginal, +X, -ListaSinXs), que elimina todas las ocurrencias de X de la lista ListaOriginal.

borrar([],_,[]). % si la lista esta vacia entonces no hay elementos que sacarle.
borrar([X|XS],Y,[X|L]) :- X \= Y, borrar(XS,Y,L). % si la lista no tiene al elemento Y, agregamos X a L.
borrar([X|XS],X,L) :- borrar(XS,X,L). % si la lista tiene al elemento X, lo ignoramos.

% 3) sacarDuplicados(+L1, -L2), que saca todos los elementos duplicados de la lista L1.

sacarDuplicados([],[]). % si L1 esta vacia, no hay nada que sacar.
sacarDuplicados([X|XS],L) :- member(X,XS), sacarDuplicados(XS,L).
sacarDuplicados([X|XS],[X|L]) :- not(member(X,XS)), sacarDuplicados(XS,L).

% 4) permutación(+L1, ?L2), que tiene éxito cuando L2 es permutación de L1. ¿Hay una manera más eficiente de definir este predicado para cuando L2 está instanciada?

%permutación()

% 5) reparto(+L, +N, -LListas) que tenga éxito si LListas es una lista de N listas (N ≥ 1) de cualquier longitud - incluso vacías - tales que al concatenarlas se obtiene la lista L.
