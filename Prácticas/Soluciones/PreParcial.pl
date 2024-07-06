
montana(L, L1, C, L2) :-  append(L1, [C|L2], L),L2 \= [], esCreciente(L1),  esDecreciente([C|L2]). 

esCreciente([]).             
esCreciente([_]).           
esCreciente([X, Y|Xs]) :-  X < Y, esCreciente([Y|Xs]).

esDecreciente([_]).        
esDecreciente([X, Y|Xs]) :- X > Y, esDecreciente([Y|Xs]).

todasLasListas(A,L) :- desde(1,S), generarLista(A,L,S).

generarLista(_,[],0).
generarLista(A,[X|LS],Len) :- Len > 0, member(X,A), NuevaLen is Len - 1, generarLista(A,LS,NuevaLen).

desde(X,X).
desde(X,Y) :- N is X + 1, desde(N,Y).

%%%%%%%%%%%%%%%%%%%%

masRepetido(L, X) :- member(X, L), repeticiones(L, X, Reps), not((member(Elem2, L), X \= Elem2, repeticiones(L, Elem2, Reps2), Reps2 > Reps)).

repeticiones([], _, 0).
repeticiones([X|XS], X, Reps) :- repeticiones(XS, X, Reps1), Reps is Reps1 + 1.
repeticiones([X|XS], Y, Reps) :- X \= Y,repeticiones(XS, Y, Reps).

%%%%%%%%%%%%%%%%%%%

sublistaMasLargaDePrimos(L,S) :- sublista(S,L), todosPrimos(S),length(S,Len), not((sublista(S2,L), todosPrimos(S2),length(S2,Len2), Len2>Len)).

sublista(S,L) :- append(_,L2,L), append(S,_,L2).

todosPrimos([]).
todosPrimos([X|XS]) :- esPrimo(X), todosPrimos(XS).

esPrimo(P) :- P \= 1, P2 is P-1, not((between(2,P2,D), mod(P,D) =:= 0)).

elemento(L,P) :- member(P,L), P > 3.