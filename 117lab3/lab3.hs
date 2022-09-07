-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
import Queue1
-- import Queue2
import Fraction
import GHC.Exts.Heap (GenClosure(queue))

---------------- Part 1: Queue client

-- add a list of elements, in order, into a queue
adds :: [a] -> Queue a -> Queue a
adds xs q=help xs q where
help [] q = q
help (x:xs) q = addq x(help xs q)

-- remove all elements of the queue, putting them, in order, into a list
rems :: Queue a -> [a]
rems q = help q where
    help q l= if ismt q then l else
         help (snd(remq q)) (fst(remq q):l) 


-- test whether adding a given list of elements to an initially empty queue
-- and then removing them all produces the same list (FIFO). Should return True.
testq :: Eq a => [a] -> Bool
testq xs = xs == rems (adds xs mtq)


---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average xs = sum xs * len xs 1 where
    len [] n= error "Illegal fraction"
    len [x] n= fraction 1 n
    len (x:xs) n= len xs (n+1)

-- Some lists of fractions
list1:: [fraction]
list1 = [fraction n (n+1) | n <- [1..20]]

list2:: [fraction]
list2 = [fraction 1 n | n <- [1..20]]

list3:: [fraction]
list3 = zipWith (+) list1 list2

-- Make up several more lists for testing
list4 :: [Fraction]
list4 = map(+ fraction 4 5) list1

list5 :: [Fraction]
list5 =[fraction 1 n | n <- [1..20]]

-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
test1 :: Bool
test1 =  last (sort list1) == maximum list1

test2::Bool
test2 = head (sort list2)== minimum list2

test3::Bool
test3 = product list3 == help list3 where
    help []= fraction 1 1
    help [x]= x
    help (x:xs)=x*help xs

test4::Bool
test4 =sum list4 == help list4 where
    help [] = fraction 1 1
    help [x] = x
    help (x:xs)= x+ help xs

test5::Bool
test5 = average list5== sum list5 * fraction 1 (len list5) where
    len [] = 0
    len [x]= 1
    len (x:xs) = len xs+1