montana(L,L1,C,L2) :- subidaMasGrande(L,S), bajada(L,L2), append(S,L2,L), append(L1,[C],S), noMismoNivel(S,L2).


noMismoNivel(S,[Y|_]) :- last(X,S) , X \= Y.

subidaMasGrande(L,S) :- subida(L,S), not((subida(L,S2), length(S,SL), length(S2,S2L), S2L > SL)).
subida(L,S) :- append(S,_,L), esCreciende(S).

esCreciende([_]).
esCreciende([X,Y|Xs]) :- X<Y , esCreciende([Y|Xs]).

bajada(L,S) :- append(_,S,L), esDecreciente(S).

esDecreciente([_]).
esDecreciente([X,Y|Xs]) :- X>Y, esCreciende([Y|Xs]).


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

%%%%%%%%%%%%%%%%%%%%
palabra(A,Len,P) :- generarLista(A,P,Len).

 % frase no anda, no lo entiendo
frase(_,[]).
frase(A,[F|Fs]) :- desde(1,S), palabraDeLargoHasta(A,L,F), between(0,L,L2), length([F|FS],L2), L3 is L2-1, frase2(A,FS,L3,L).

palabraDeLargoHasta(A,F,L) :- between(1,L,Len), palabra(A,Len,F).

frase2(A,[],0,_).
frase2(A,[X|XS],N,L) :- palabraDeLargoHasta(A,L,X), N2 is N-1, frase2(A, XS,N2,L).