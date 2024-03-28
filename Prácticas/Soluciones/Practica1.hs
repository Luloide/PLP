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
normaVectorial x y = sqrt( x^2 + y ^2)

-- Ejercicio 2
curry :: (t1 -> t2 -> t3) -> t1 -> t2 -> t3
curry f a b = f a b

uncurry :: (t1 -> t2 -> t3) -> (t1,t2) -> t3
uncurry f (x, y) = f x y

-- Ejercicio 3
sumFold :: Num a => [a] -> a 
sumFold = foldr (+) 0 

--elem' :: [a] -> a -> Bool
--elem' n= foldr (\x -> x == n) False