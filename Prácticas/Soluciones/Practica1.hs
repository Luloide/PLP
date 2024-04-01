import Data.Binary.Get (label)
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


-- lo pienso primero con recursion explicita a ver si veo algo
--sumasParciales :: Num a => [a] -> [a]


sumasParcialesaux :: Num a => a -> [a] -> [a] -- necesito un acumulador seguro, entonces foldl?, pero ademas debo devolver una lista
sumasParcialesaux _ [] = []
sumasParcialesaux n (x:xs) = (x + n) : sumasParcialesaux (x + n) xs

--sumaAlt :: [Int] -> Int
--sumaAlt = foldr 