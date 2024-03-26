-- Ejercicio 1
{-
las que arrancan con ! es que estan currificada
! max2 :: Ord a => (a,a) -> a
! normaVectorial :: (Float, Float) -> float 
substract :: Float -> Float -> Float
! predecesor :: Float -> Float
! evaluarEnCero :: (Float -> a) -> a
dosveves :: (a -> a) -> a -> a
! flipAll :: [a -> b -> c] -> [b -> a -> c]
flipraro :: b -> (a -> b -> c) -> a -> c
-}

-- Ejercicio 2
curry :: (t1 -> t2 -> t3) -> t1 -> t2 -> t3
curry f a b = f a b

uncurry :: (t1 -> t2 -> t3) -> (t1,t2) -> t3
uncurry f (x, y) = f x y

-- Ejercicio 3
fsum :: [Int] -> Int
fsum l = foldr (+) 0 l

felem :: Eq a => a -> [a] -> Bool
felem e l = foldr (\ x y -> y || (x == e)) False l

--fcon :: [a] -> [a] ->[a]
--fcon l a = foldr () [] l 