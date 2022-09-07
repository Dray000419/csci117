module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving Eq


-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible
frac :: Integer -> Integer -> Maybe Fraction
frac a b= if b==0 then Nothing
else if b<0 then Just (Frac (-a) (-b))
else if gcd a b /=1 then Just (Frac a b)
else Just (Frac a b) where
    Frac a b= if gcd a b ==1 then Frac a b 
    else Frac (a`div` gcd a b) (b `div` gcd a b)
    


-- Show instance that outputs Frac n m as n/m
instance Show Fraction where
    show (Frac a b ) = show a ++ "/" ++ show b
-- Ord instance for Fraction
instance Ord Fraction where
    compare (Frac a b)  (Frac c d) = if b==0 || d==0 then error "Illegal fraction" else (compare (d*a) (c*b))

fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
                Nothing -> error "Illegal fraction"
                Just fr -> fr
-- Num instance for Fraction
instance Num Fraction where
    negate (Frac a b)= fraction (-a) b
    (Frac a b)+(Frac c d)= fraction (a*d+c*b) (b*d)
    (Frac a b)*(Frac c d)= fraction (a*c) (b*d)
    (Frac a b)-(Frac c d)=fraction (a*d-c*b) (b*d) 
    abs (Frac a b)=if a <0 then fraction (-a) b else fraction a b
    signum (Frac a b)
        | b==0 = error "numerator can't be 0"
        | a > 0 = 1
        | a == 0 = 0
        | otherwise = - 1
    fromInteger a = Frac a 1