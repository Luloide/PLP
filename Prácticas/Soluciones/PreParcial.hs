--Practica esquemas de recurcion
--Ejercicio 3 
-- definir usando foldr las funciones sum, elem, (++), filter y map
sum2 :: Num a => [a] -> a
sum2 = foldr (+) 0

elem2 :: Eq a => a -> [a] -> Bool
elem2 elem = foldr (\x rec -> if x == elem then True else rec) False

-- esto vendria a ser map
mapa :: (a -> b) -> [a] -> [b]
mapa f = foldr (\elem rec -> (f elem) : rec) []

-- esto vendria a ser fliter 
filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f = foldr (\x rec -> if f x then x : rec else rec) []

-- (++)
concatenar :: [a] -> [a] -> [a] 
concatenar a b = foldr (\x rec -> x : rec) b a

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec) 

-- Otras Estucturas De Datos

foldNat :: (Integer -> b -> b) -> b -> Integer -> b 
foldNat f z 1 = z
foldNat f z n = f n (foldNat f z (n-1))

-- potencia ceria a^b
potencia :: Integer -> Integer -> Integer
potencia a b = foldNat (\_ rec -> a * rec) a b

data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)
-- los casos bases serian x y cte a, por otro lado los casos recursivos son suma y prod.

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPoli cX cCte fsuma fprod poli = case poli of
    X -> cX 
    Cte a -> cCte a
    Suma p1 p2 -> fsuma (rec p1) (rec p2)
    Prod p1 p2 -> fprod (rec p1) (rec p2)
    where rec = foldPoli cX cCte fsuma fprod

evaluar :: Num a => a -> Polinomio a -> a
evaluar n = foldPoli n (\a -> a) (\p1 p2 -> p1 + p2) (\p1 p2 -> p1 * p2) 

data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b 
foldAB cNil fBin arbol = case arbol of 
    Nil -> cNil
    Bin i r d -> fBin (rec i) r (rec d)
    where rec = foldAB cNil fBin

recAB :: b -> (AB a -> a -> AB a -> b -> b -> b) -> AB a -> b
recAB cNil fBin arbol = case arbol of 
    Nil -> cNil
    Bin i r d -> fBin i r d (rec i) (rec d)
    where rec = recAB cNil fBin 

esNil :: AB a -> Bool
esNil tree = case tree of 
    Nil -> True
    Bin _ _ _ -> False 

altura :: AB a -> Int
altura = foldAB 0 (\i _ d -> 1 + max i d )

alturaConRec :: AB a -> Int
alturaConRec = recAB 0 (\_ _ _ i d -> 1 + max i d) 

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\i _ d -> 1 + i + d)

cantNodosConRec :: AB a -> Int
cantNodosConRec = recAB 0 (\_ _ _ i d -> 1 + i + d)

--esABB :: Ord a => AB a -> Bool




