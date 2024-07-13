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
-- ej11
foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat f z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia n d = foldNat (\_ rec -> n * rec) 1 d

--ej 12
data Polinomio a = X | Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)

foldPoli :: b -> (a->b) -> (b -> b -> b) -> (b-> b-> b) -> Polinomio a -> b
foldPoli cX cCte fSuma fProd poli = case poli of 
    X -> cX 
    Cte a -> cCte a
    Suma x y -> fSuma (rec x) (rec y)
    Prod x y -> fProd (rec x) (rec y)
    where rec =  foldPoli cX cCte fSuma fProd 

evaluar :: Num a => a -> Polinomio a -> a 
evaluar n = foldPoli n (\a -> a) (\p1 p2 -> p1 + p2) (\p1 p2 -> p1 * p2)


--ej 13
data AB a = Nil | Bin (AB a) a (AB a)
tree = Bin (Bin Nil 2 Nil) 1 (Bin (Bin Nil 4 Nil) 3 (Bin Nil 5 Nil))

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b 
foldAB fNil fBin tree = case tree of
    Nil -> fNil
    Bin i r d -> fBin (rec i) r (rec d)
    where rec = foldAB fNil fBin

recAB :: b -> (AB a -> a -> AB a -> b -> b -> b) -> AB a -> b
recAB cNil fBin tree = case tree of 
    Nil -> cNil
    Bin i r d -> fBin i r d (rec i) (rec d)
    where rec = recAB cNil fBin 

-- un test mio nomas, intento definir fold a partir de rec
foldABRec ::b -> (b -> a -> b -> b) -> AB a -> b 
foldABRec fNil fBin = recAB fNil (\_ r _ i d -> fBin i r d)

esNil :: AB a -> Bool
esNil tree = case tree of
    Nil -> True
    Bin i r d -> False

altura :: AB a -> Int
altura = foldAB 0 (\left _ right -> 1 + max left right)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\left _ right -> 1 + left + right)

-- Ejercicio 14
cantHojas :: AB a -> Int
cantHojas = foldAB 0 (\left _ right -> if (left == 0 && right == 0) then 1 else left + right)

ramas :: AB a -> Int
ramas = cantHojas

espejo :: AB a -> AB a 
espejo = recAB Nil (\i r d left right -> Bin d r i)

mismaEStructura :: AB a -> AB b -> Bool
mismaEStructura t1 t2 = False

--ej 15
data AIH a = Hoja a | Bin2 (AIH a) (AIH a)

foldAIH :: (a -> b) -> (b ->b -> b) -> AIH a -> b 
foldAIH fHoja fBin2 tree = case tree of 
    Hoja a -> fHoja a
    Bin2 i d -> fBin2 (foldAIH fHoja fBin2 i) (foldAIH fHoja fBin2 d)

alturaAIH :: AIH a -> Integer
alturaAIH = foldAIH (const 1) (\left right -> max left right) -- por lo que entendi del ejercicio si no es una hoja no cuenta para la altura (?

tamano :: AIH a -> Integer 
tamano = foldAIH (const 1) (\left right -> left + right) -- cantidad de hojitas 

-- Ejercicio 16
data RoseTree a = Rose a [RoseTree a]

foldRT :: (a -> [b] -> b) -> RoseTree a -> b
foldRT f (Rose x hijos) = f x (map (foldRT f) hijos)

hojas :: RoseTree a -> [a]
hojas = foldRT (\x hijos -> if null hijos then [x] else concat hijos)

