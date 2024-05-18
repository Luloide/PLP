-- ejercicios p1, otras estructuras de datos
-- ej11
foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat f z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer
potencia n d = foldNat (\d rec -> n * rec) 1 d

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