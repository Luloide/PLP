import Prelude hiding (Right, Left, Either, Just, Nothing, Maybe)
{- Ejercicio 1
- null es de tipo [a] -> bool, lo que hace es devolver True si la lista esta vacia,
 en caso contrario devuelve False.

- head es del tipo [a] -> a, lo que hace es devolver el primer elemento de la lista.

- tail es del tipo [a] -> [a], lo que hace es devolver la lista sin el primer elemento.  

- init es del tipo [a] -> [a], devuelve la lista sin el ultimo elemento.  

- last es del tipo [a] -> a, devuelve el ultimo elemento de la lista

- take es del tipo Int -> [a] -> [a], lo que hace es crear una lista, el primer argumento determina
cuantos elementos deben ser tomados de la lista pasada como segundo argumento.

- drop es del tipo 	Int -> [a] -> [a], lo que hace es sacar los n primerons elementos pasados como primer parametro
y sacarlos de la lista pasada como segundo parametro. 
ej: 
Input: drop 5 [1,2,3,4,5,6,7,8,9,10]
Output: [6,7,8,9,10]

- (++) es del tipo [a] -> [a] -> [a], lo que hace es concatenar las dos listas pasadas como argumento. 

- concat [[a]] -> [a], acepta una lista de lista y una lista y las concatena

- (!!) es del tipo [a] -> Int -> a, lo que hace es devolverte el elemento en cierto indice pasado como segundo argumento. 
ej:
Input: (!!) [1,2,3,4] 2
Output: 3

- elem es del tipo a -> [a] -> Bool, devuelve True si en la lista hay un elemento igual al elemento pasado
como segundo argumento
-}

-- Ejercicio 2
valorAbsoluto :: Float -> Float 
valorAbsoluto n | n >= 0 = n
                | otherwise = -n 

bisiesto :: Int -> Bool
bisiesto n = if ((mod n 4 == 0) && (mod n 100 == 0) && (mod n 400 /= 0)) then False else True

factorial :: Int -> Int 
factorial 0 = 1
factorial n = n * factorial (n-1)

cantDivisoresPrimos :: Int -> Int 
cantDivisoresPrimos 0 = 0
cantDivisoresPrimos n | esPrimo n = 1 + cantDivisoresPrimos (n-1)
                      | otherwise = cantDivisoresPrimos (n - 1)

esPrimo :: Int -> Bool
esPrimo n | n <= 1    = False
          | otherwise = noEsDivisible n 2
  where
    noEsDivisible :: Int -> Int -> Bool
    noEsDivisible m divisor
      | divisor * divisor > m        = True
      | m `mod` divisor == 0         = False
      | otherwise                    = noEsDivisible m (divisor + 1)

-- Ejercicio 3
data Maybe a = Nothing | Just a
data Either a b = Left a | Right b

inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1 / n)

aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right n) | n == True = 1
                  | n == False = 0 


-- Ejercicio 4
limpiar :: String -> String -> String 
limpiar _ [] = []
limpiar l (x:xs) | elem x l = limpiar l xs
                 | otherwise = x : limpiar l xs

difPromedio :: [Float] -> [Float]
difPromedio l = difPromedioaux l l


difPromedioaux :: [Float] -> [Float] -> [Float]
difPromedioaux [] _ = []
difPromedioaux (x:xs) l = x - promedioGen : difPromedioaux xs l 
    where
        promedioGen = sum l / fromIntegral (length l) 


todosIguales :: [Int] -> Bool
todosIguales l | null (tail l) = True
               | head l /= head (tail l) = False 
               | otherwise = todosIguales (tail l)

-- Ejercicio 5 
data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB (Bin Nil _ Nil) = True
vacioAB _ = False

-- esta instancia es para poder visualizar el arbol al evaluar negacion
instance Show a => Show (AB a) where
    show :: Show a => AB a -> String
    show Nil = "Nil"
    show (Bin left val right) = "(Bin " ++ show left ++ " " ++ show val ++ " " ++ show right ++ ")"

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin Nil True Nil) = Bin Nil False Nil
negacionAB (Bin Nil False Nil) = Bin Nil True Nil
negacionAB (Bin a True b ) = Bin (negacionAB a) False (negacionAB b)
negacionAB (Bin a False b ) = Bin (negacionAB a) True (negacionAB b)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin Nil n Nil) = n
productoAB (Bin left n right) = n * productoAB left * productoAB right