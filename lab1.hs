-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- Work through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.


---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------


{-
toEnum :: Enum a => Int -> a
Main*> (toEnum 3) :: Color
Green
Main*> (toEnum 2) :: Int   
2
Main*> (toEnum 2) :: Float
2.0
toEnum is used to sequentially order from 0 to ...


fromEnum :: Enum a => a -> Int
Main*> (fromEnum 3) :: Int  
3
Main*> (fromEnum Red)       
0
Main*> (fromEnum True)   
1
fromEnum can be used for many different type 

enumFrom :: Enum a => a -> [a]
Main*> (enumFrom Red)       
[Red,Orange,Yellow,Green,Blue,Violet]
Main*> (enumFrom Blue)
[Blue,Violet]
Main*> (enumFrom Violet)
[Violet]
enumFrom means when you type something in it, it will start from it until end

enumFromThen :: Enum a => a -> a -> [a]
Main*> enumFromThen Red Violet
[Red,Violet]
Main*> enumFromThen Red Orange 
[Red,Orange,Yellow,Green,Blue,Violet]
Main*> enumFromThen Yellow Green
[Yellow,Green,Blue,Violet]
enumFromThen means if you type two , which are followed. then it will dispiay others that follow the last one

enumFromTo :: Enum a => a -> a -> [a]
Main*>  enumFromTo Yellow Green         
[Yellow,Green]
Main*>  enumFromTo Yellow Violet
[Yellow,Green,Blue,Violet]
Main*>  enumFromTo Red Violet   
[Red,Orange,Yellow,Green,Blue,Violet]
enumFromTo means put everything between first one and last one together

enumFromThenTo :: Enum a => a -> a -> a -> [a]
Main*> enumFromThenTo 2 3 5
[2,3,4,5]
Main*> enumFromThenTo 2 3 9
[2,3,4,5,6,7,8,9]
Main*> enumFromThenTo Red Orange Violet
[Red,Orange,Yellow,Green,Blue,Violet]
returns proceeding values according to amount of value skipped between the first 2 inputs, up until 3rd input
-}

-- ==, /= ---------------------------------------------------------------------
{-
Main*> :t (==)
(==) :: Eq a => a -> a -> Bool
Main*> 2==3
False
Main*> Red == Green
False
Main*> Red == Red  
True
it means first one equal to second one . otherwise returns false.

ghci> :t (/=)
(/=) :: Eq a => a -> a -> Bool
ghci> 2/=3   
True
ghci> 2/=2
False
ghci> 2.5/=2.4
True
It used to define if both number or are not equal
-}
-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
{-
Main*> :t quot
quot :: Integral a => a -> a -> a
Main*>-7 `quot` 3 
-2
Main*>-3 `quot` 7 
0
Main*>3 `quot` 3 
1
for quot, it can divide any number for positive, and get the truncated toward zero


Main*>:t div
div :: Integral a => a -> a -> a
Main*>-20 `div` 5
-4
Main*>20 `div` 5 
4
Main*>-15 `div` 4
-3
the definition for div is "integer division truncated toward negative infinity

-}
-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
{-
Main*>:t rem
rem :: Integral a => a -> a -> a
Main*>-20 `rem` 6 
-2
Main*>-3 `rem` 2 
-1
Main*>-8 `rem` 2
0
Rem: returns reminder of integer division of the arguments

Main*>:t mod
mod :: Integral a => a -> a -> a
Main*>(-2)  `mod` (-3)
-2
Main*>2  `mod` (-3)
-1
Main*>(-20)  `mod` (3) 
1
mod : Returns the modulus of the two numbers. This is similar to the remainder but has different rules when "div" returns a negative number.


-}
-- quotRem, divMod ------------------------------------------------------------
{-
quotRem :: Integral a => a -> a -> (a, a)
Main*>(-20) `quotRem` 3
(-6,-2)
Main*>(20) `quotRem` 3 
(6,2)
Main*>(-40) `quotRem` 3 
(-13,-1)
use second number * first result then add second result to get the first number

Main*>:t divMod
divMod :: Integral a => a -> a -> (a, a)
Main*>(-40) `divMod` 3
(-14,2)
Main*>(-20) `divMod` 3
(-7,1)
Main*>(20) `divMod` 3  
(6,2)
use second number * first result then minus  second result to get the first number
-}
-- &&, || ---------------------------------------------------------------------
{-
Main*>:t (&&)
(&&) :: Bool -> Bool -> Bool
Main*>True && True
True
Main*>False && True
False
Main*>False && False
False
if two input are the same get same answer, like T or F

Main*>:t (||)
(||) :: Bool -> Bool -> Bool
Main*>True || True
True
Main*>True || False
True
Main*>False || False
False
each one are True, answer get T, otherwise all False
-}
-- ++ -------------------------------------------------------------------------
{-
Main*>:t (++)
(++) :: [a] -> [a] -> [a]
Main*>[1,2] ++ [3,4]
[1,2,3,4]
Main*>[1,2] ++ [3,4,1]
[1,2,3,4,1]
Main*>[1,2,5] ++ [3,4,1]
[1,2,5,3,4,1]
get two zip added together, and answer follow the sequence
-}
-- compare --------------------------------------------------------------------
{-
Main*>:t compare
compare :: Ord a => a -> a -> Ordering
Main*>1 `compare` 4
LT
Main*>5 `compare` 4
GT
Main*>5 `compare` 5
EQ
make a compare with both integer then get answer LT, GT, EQ

-}
-- ^ --------------------------------------------------------------------------
{-
Main*>:t (^)
(^) :: (Integral b, Num a) => a -> b -> a
Main*>3.0 ^ 2  
9.0
Main*>3 ^ 2  
9
Main*>3 ^ 0
1
Main*>3 ^ 3
27
second number as the square time to the  first one 


-}
-- concat ---------------------------------------------------------------------
{-
Main*>:t concat
concat :: Foldable t => t [a] -> [a]
Main*>concat [[1,2], [1,2,3]]
[1,2,1,2,3]
Main*>concat [[1,2,3], [1,2,3]]
[1,2,3,1,2,3]
Main*>concat [[1,2,3], [1,2,3,6]]
[1,2,3,1,2,3,6]
connect both lists together and follow the sequence
-}
-- const ----------------------------------------------------------------------
{-
Main*>:t const
const :: a -> b -> a
Main*>const 12 4         
12
Main*>const 3 4 
3
Main*>const 12.0 4
12.0
for 2 integer, only get first one 

-}
-- cycle ----------------------------------------------------------------------
{-
Main*>:t cycle
cycle :: [a] -> [a]
Main*>take 2 (cycle[1,2])
[1,2]
Main*>take 10 (cycle[1,2,3,4])
[1,2,3,4,1,2,3,4,1,2]
Main*>take 10 (cycle[Red, Green])
[Red,Green,Red,Green,Red,Green,Red,Green,Red,Green]
repeat your input forever, or you make a requirement like how many input then stop it
-}
-- drop, take -----------------------------------------------------------------
{-
drop :: Int -> [a] -> [a]
Main*>drop 1 [1,2]
[2]
Main*>drop 2 [1,2,3,4]
[3,4]
Main*>drop 0 [1,2,3,4]
[1,2,3,4]
put a number befor [], means how many take out from left to right

take :: Int -> [a] -> [a]
Main*>take 1 [1,2,3]
[1]
Main*>take 2 [1,2,3]
[1,2]
Main*>take 4 [1,2,3,4,5]
[1,2,3,4]
put a number befor [], means how many you want to show from left to right
-}
-- elem -----------------------------------------------------------------------
{-
Main*>:t elem   
elem :: (Foldable t, Eq a) => a -> t a -> Bool
Main*>'o' `elem` "zion"
True
Main*>elem 1 [1,12,3]  
True
Main*>10 `elem` [1..9]  
False
ensure if the first put is inside of the second one
-}
-- even -----------------------------------------------------------------------
{-
even :: Integral a => a -> Bool
Main*>even 2
True
Main*>even 24
True
Main*>even 3 
False
depends on your input is even or not .even return True
-}

-- fst ------------------------------------------------------------------------
{-
fst :: (a, b) -> a
Main*>fst (1,3)
1
take first number in a tuple
-}

-- gcd ------------------------------------------------------------------------
{-
Main*>:t gcd
gcd :: Integral a => a -> a -> a
Main*>gcd 1 2
1
Main*>gcd 4 2
2
Main*>gcd 20 12
4
return a number that can be devided's greatest number
-}
-- head -----------------------------------------------------------------------
{-
head :: [a] -> a
Main*>head [1,2,3,5]
1
Main*>head [2,3,5]  
2
Main*>head "hello"
'h'
returns the first item of a list

-}
-- id -------------------------------------------------------------------------
{-
Main*>:t id
id :: a -> a
Main*>id 13
13
Main*>id 1
1
used to identify function
-}
-- init -----------------------------------------------------------------------
{-
Main*>:t init
init :: [a] -> [a]
Main*>init [1,2,3,4]
[1,2,3]
Main*>init "Hello"     
"Hell"
Main*>init [Red,Yellow]
[Red]
return all the input except the last one
-}
-- last -----------------------------------------------------------------------
{-
Main*>:t last
last :: [a] -> a
Main*>last [1,2,3]
3
Main*>last [Red,Yellow,Green]
Green
ain*>last "Hello"           
'o'
only returns the last one
-}
-- lcm ------------------------------------------------------------------------
{-
Main*>:t lcm
lcm :: Integral a => a -> a -> a
Main*>lcm 1 3  
3
Main*>lcm 10 3
30
Main*>lcm 3 9 
9
answer is the lowest common multiple for both inputs
-}
-- length ---------------------------------------------------------------------
{-
Main*>:t length
length :: Foldable t => t a -> Int
Main*>length [1,2,3,4]
4
Main*>length "Hello"  
5
Main*>length []       
0
get how many number of input in this list
-}
-- null -----------------------------------------------------------------------
{-
Main*>:t null
null :: Foldable t => t a -> Bool
Main*>null [Red]
False
Main*>null []   
True
Main*>null [1,2,3]
False
returns True if a list is empty, otherwise False

-}
-- odd ------------------------------------------------------------------------
{-
Main*>:t odd
odd :: Integral a => a -> Bool
Main*>odd 2 
False
Main*>odd 23
True
return true if input is odd number, otherwise false
-}
-- repeat ---------------------------------------------------------------------
{-
Main*>:t repeat
repeat :: a -> [a]
Main*>take 3 (repeat [1,2])  
[[1,2],[1,2],[1,2]]
Main*>take 2 (repeat 'A')
"AA"
Main*>take 2 (repeat "A")
["A","A"]
it creates an infinite list where all items are the first argument

-}
-- replicate ------------------------------------------------------------------
{-
Main*>:t replicate
replicate :: Int -> a -> [a]
Main*>replicate 5 [1,2,3]
[[1,2,3],[1,2,3],[1,2,3],[1,2,3],[1,2,3]]
Main*>replicate 5 "red"  
["red","red","red","red","red"]
Main*>replicate 5 'r'  
"rrrrr"
creates a list of length given by the first argument and the items having value of the second argument

-}
-- reverse --------------------------------------------------------------------
{-
Main*>:t reverse
reverse :: [a] -> [a]
Main*>reverse [1,2,3,4]
[4,3,2,1]
Main*>reverse [4,3,2,1]
[1,2,3,4]
Main*>reverse [1..9]   
[9,8,7,6,5,4,3,2,1]
make your string reverse
-}

-- snd ------------------------------------------------------------------------
{-
Main*>:t snd
snd :: (a, b) -> b
Main*>snd (1,2)
2
Main*>snd (2,1)        
1
just get the second input
-}

-- splitAt --------------------------------------------------------------------
{-
splitAt :: Int -> [a] -> ([a], [a])
Main*>splitAt 3 [1,2,3]
([1,2,3],[])
Main*>splitAt 3 ["Red","Yellow","Violet"]
(["Red","Yellow","Violet"],[])
Main*>splitAt 3 [1,2,3,4,5,6,7,8,9]      
([1,2,3],[4,5,6,7,8,9])
make a split at your input after splitAt, then divided by two part
-}
-- zip ------------------------------------------------------------------------
{-
Main*>:t zip
zip :: [a] -> [b] -> [(a, b)]
Main*>zip [1,2] [1,2,3,4,5]
[(1,1),(2,2)]
Main*>zip [2,3,5] [1,2,3,4,5]
[(2,1),(3,2),(5,3)]
Main*>zip [2,3,5] ["Red","Yellow", "Green"]
[(2,"Red"),(3,"Yellow"),(5,"Green")]
its like become a pair, from same position
-}

-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------
{-
Main*>:t all
all :: Foldable t => (a -> Bool) -> t a -> Bool
Main*>all even [2,4,6,8]
True
Main*>all(<10) [1,5,7,11,13]
False
Main*>all (/=1) [5,7,9]
True
if the list good for your condition, return true

Main*>:t any
any :: Foldable t => (a -> Bool) -> t a -> Bool
Main*>any (<10) [1,3,5]
True
Main*>any (<10) [1,3,5,10,11]
True
Main*>any (<10) [11,13,15,19]
False
if any one of the input is fit for the condition, return true. otherwise return false.
-}
-- break ----------------------------------------------------------------------
{-
Main*>:t break
break :: (a -> Bool) -> [a] -> ([a], [a])
Main*>break (<3) [1,2,3,4,5,6]
([],[1,2,3,4,5,6])
Main*>break (>3) [1,2,3,4,5,6]
([1,2,3],[4,5,6])
Main*>break (==3) [1,2,3,4,5,6]
([1,2],[3,4,5,6])
if the list fits the condition, like <3, >3 or ==3,// 从第几个数字满足它的条件，就从哪一个开始把后面剩下的数字都放在第二个框框里面。不符合的放第一个。都不符合就放第一个框框.
put the those in second one, start from the first input that fits the condition
-}
-- dropWhile, takeWhile -------------------------------------------------------
{-
Main*>:t dropWhile
dropWhile :: (a -> Bool) -> [a] -> [a]
Main*>dropWhile(<3) [1,2,3,4,5]
[3,4,5]
Main*>dropWhile(>3) [1,2,3,4,5]
[1,2,3,4,5]
Main*>dropWhile(==1) [1,2,3,4,5]
[2,3,4,5]
the result will appear a list from the element that it doesn't fit the condition//从另一个列表创建一个列表，它检查原始列表并从中获取从条件第一次失败到列表末尾的元素
-}
-- filter ---------------------------------------------------------------------
{-
Main*>:t filter
filter :: (a -> Bool) -> [a] -> [a]
Main*>filter (<3) [1,4,6]
[1]
Main*>filter odd [1,3,6,8,9]
[1,3,9]

-}
-- iterate --------------------------------------------------------------------
{-
Main*>:t iterate
iterate :: (a -> a) -> a -> [a]
Main*>take 3 (iterate (2*)1)
[1,2,4]
Main*>take 3 (iterate (2*)3)
[3,6,12]
Main*>take 3 (iterate (\x->(x+2)*2)3)
[3,10,24]
the result start from the last num we input, then calculate the next one from the previous result we got, into that function 
-}
-- map ------------------------------------------------------------------------
{-
Main*>:t map
map :: (a -> b) -> [a] -> [b]
Main*>map (*2) [1,2,3,4]
[2,4,6,8]
Main*>map reverse ["Red"]  
["deR"]
Main*>map reverse ["Red","1,2,3,4"]
["deR","4,3,2,1"]
use the first function(like abs, reverse or something) to return the list then get answer
-}
-- span -----------------------------------------------------------------------
{-
Main*>:t span
span :: (a -> Bool) -> [a] -> ([a], [a])
Main*>span (<4) [1,2,5,6,8]
([1,2],[5,6,8])
Main*>span (==4) [1,2,5,6,8]
([],[1,2,5,6,8])
Main*>span (>4) [1,2,5,6,8] 
([],[1,2,5,6,8])
if the first number of the input list doesn't fit the condition, span wil automatically put whole list in to second answer list.
if the first number of the input list fit the condition, it will go normal until condition doesn't fit the next one.
-}
