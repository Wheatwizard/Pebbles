ir :: [Char] -> Integer -> [Char]
ir x 0 = ""
ir ('(':x) y = "(" ++ (ir x (y+1))
ir (')':x) y = ")" ++ (ir x (y-1))
ir (a:x)   y = [a] ++ (ir x   y  )

interior :: [Char] -> [Char]
interior x = init (ir x 1)

ex :: [Char] -> Integer -> [Char]
ex x 0 = x
ex ('(':x) y = ex x (y+1)
ex (')':x) y = ex x (y-1)
ex  (a:x)  y = ex x y

exterior :: [Char] -> [Char]
exterior x = ex x 1

front :: Bool -> ([Bool], [Bool], [Bool]) -> ([Bool], [Bool], [Bool])
front h (a, b, c) = (a, b, h:c)

xor :: Bool -> Bool -> Bool
xor True  x = not x
xor False x =     x

pb :: String -> ([Bool], [Bool], [Bool]) -> ([Bool], [Bool], [Bool])
pb [] x = x
pb ('~':s) (ha:a, hb:b, o) = pb s (hb:a, ha:b, o)
pb ('>':s) (a, hb:b, o)    = front hb (pb s (a, hb:b, o))
pb ('<':s) (ha:a, b, o)    = front ha (pb s (ha:a, b, o))
pb ('[':s) (ha:a, b, o)    = pb s (a, ha:b, o)
pb (']':s) (a, hb:b, o)    = pb s (hb:a, b, o)
pb ('&':'(':s) x = loop (&&)  s x
pb ('|':'(':s) x = loop (||)  s x
pb ('^':'(':s) x = loop (xor) s x
pb ('!':'!':s) x = pb s x
pb ('!':'&':'(':s) x = loop ((&&).not) s x
pb ('!':'|':'(':s) x = loop ((||).not) s x
pb ('!':'^':'(':s) x = loop (xor.not)  s x
pb (_:s) x = pb s x

loop :: (Bool -> Bool -> Bool) -> String -> ([Bool], [Bool], [Bool]) -> ([Bool], [Bool], [Bool])
loop p s (ha:a, hb:b, o) = (if (p ha hb) then
                                    (pb (exterior s) (ha:a, hb:b, o))
                                  else
                                    (pb (exterior s) (run (p) (interior s) (ha:a, hb:b, o)))
                                  )

run :: (Bool -> Bool -> Bool) -> String -> ([Bool], [Bool], [Bool]) -> ([Bool], [Bool], [Bool])
run predicate source (ha:a, hb:b, o)
 | satisfied = (ha:a, hb:b, o) 
 | otherwise = run predicate source (pb source (ha:a, hb:b, o))
 where satisfied = (predicate ha hb)

pebble :: String -> [Bool]
pebble source = (\(_,_,c)->c)(pb source (True:True:[False|x<-[0,0..]], True:True:[False|x<-[0,0..]], []))
