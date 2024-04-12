-- Ejercicio 1
{-
las que arrancan con ! es que estan currificada
1)
! max2 :: Ord a => (a,a) -> a
! normaVectorial :: (Float, Float) -> float 
substract :: Float -> Float -> Float
predecesor :: Float -> Float
evaluarEnCero :: (Float -> a) -> a
dosveves :: (a -> a) -> a -> a
flipAll :: [a -> b -> c] -> [b -> a -> c]
flipraro :: b -> (a -> b -> c) -> a -> c

2)
-}
max2 :: Ord a => a -> a -> a
max2 = \x y -> if x > y then x else y

normaVectorial :: Float -> Float -> Float
normaVectorial x y = sqrt ( x^2 + y ^2)

-- Ejercicio 2
curry :: (t1 -> t2 -> t3) -> t1 -> t2 -> t3
curry f a b = f a b

uncurry :: (t1 -> t2 -> t3) -> (t1,t2) -> t3
uncurry f (x, y) = f x y

-- Ejercicio 3
sumFold :: Num a => [a] -> a
sumFold = foldr (+) 0

elem' :: (Eq a) => [a] -> a -> Bool
elem' l n = foldr (\x acc -> x == n || acc) False l

conc :: [a] -> [a] -> [a]
conc l s = foldr (:) s l

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold f = foldr (\x rec -> if f x then x : rec else rec) []

mapFold :: (a -> b) -> [a] -> [b]
mapFold f = foldr (\x rec -> (f x) : rec) []

mejorSegun :: (a -> a -> Bool) -> [a] -> a 
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)


sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = reverse (foldl (\acc x -> (x + head acc) : acc) [] xs)


sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

sumaAlt2 :: Num a => [a] -> a
sumaAlt2 l = foldr (-) 0 (reverse l)

-- ejercicio 4

-- ejercicio 5
{-
la funcion entrelazar no es una funcion que utilize recursion estructural, en cambio elementosEnPosicionesPares si.
-}
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares l = foldr (\(x,y) acc -> if even x then acc else y: acc) [] (zip[0..] l)

--ejercicio 6 
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs) 

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna n = recr (\x xs acc -> if x == n then xs else x: acc) [] 

-- no es adecuado foldr debido a que necesitamos pasar el tail de la lista a la funcion

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado n = recr (\x xs acc -> if x >=n then n : x : xs else x : acc) []

-- Ejercicio 8
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (\(x,y) -> f x y) -- podria haber puesto tambien map uncurry f

armarPares :: [a] -> [b] -> [(a,b)]
armarPares  = foldr (\x acc (y:ys) -> (x, y) : acc ys) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f l m= mapPares f (zip l m)

-- ejercicio 10
generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = generateFrom stop next (xs ++ [next xs])

--generateBase::([a] -> Bool) -> a -> (a -> a) -> [a]
--factoriales::Int -> [Int]
--iterateN :: Int -> (a -> a) -> a -> [a]

-- ejercicio 11
foldNat :: (Integer -> Integer -> Integer) -> Integer -> Integer -> Integer
foldNat f z 0 = z
foldNat f z n = f n (foldNat f z (n - 1))

potencia :: Integer -> Integer -> Integer
potencia n = foldNat (\x acc -> n * acc) 1  

-- Ejercicio 12
data Polinomio a = X
                | Cte a
                | Suma (Polinomio a) (Polinomio a)
                | Prod (Polinomio a) (Polinomio a)

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPoli cX cCte cSuma cProd poli = case poli of
    X -> cX
    Cte k -> cCte k
    Suma p q -> cSuma (rec p) (rec q)
    Prod p q -> cProd (rec p) (rec q)
  where rec = foldPoli cX cCte cSuma cProd







-- ejercicio 13
data AB a = Nil | Bin (AB a) a (AB a)

foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB _ acc Nil = acc
foldAB f acc (Bin i r d) = f (foldAB f acc i) r (foldAB f acc d)

esNil :: AB a -> Bool
esNil Nil = True
esNil (Bin _ _ _) = False

altura :: AB a -> Int
altura = foldAB (\left _ right -> 1 + max left right) 0 

cantNodos :: AB a -> Int
cantNodos = foldAB (\left _ right -> 1 + left + right) 0
