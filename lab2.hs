-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x:zs,ys)
--ghci> deal [1,2,3,4,5,6,7]
--([1,3,5,7],[2,4,6])

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:xs)
  | x > y  = y : merge (x:xs) ys
--ghci> merge [2,8] [7,20]
--[2,7,8,20]

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = merge (ms (fst (deal xs))) (ms (snd (deal xs))) -- general case: deal, recursive call, merge
--ghci> ms [4,2,6,1,7,3]
--[1,2,3,4,6,7]       

-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons x Nil = Snoc Nil x
cons x (Snoc y z) = Snoc (cons x y) z

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList []= Nil
toBList (x:xs) = cons x(toBList xs)

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc x a = x++[a]

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc Nil a)=[a]
fromBList (Snoc b a) = snoc (fromBList b)a
{-
Ghci> inorder2' leafTree1
  Output: [12,21,23]
  Ghci> inorder2' leafTree2
  Output: [21,21,21]
  Ghci> inorder2' leafTree3
  Output: [20,19,4,321,211,21,1234,4212,512,332,13]
leafTree1 = Node2 21 (Leaf 12) (Leaf 23)
leafTree2 = Node2 21 (Leaf 21) (Leaf 21)
leafTree3 = Node2 21 (Node2 321 (Node2 19 (Leaf 20) (Leaf 4)) (Leaf 211)) (Node2 332 (Node2 4212 (Leaf 1234) (Leaf 512)) (Leaf 13))
Ghci> toBList [1..8]
  Output: Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4) 5) 6) 7) 8
  Ghci> toBList [2,5,1,2]
  Output: Snoc (Snoc (Snoc (Snoc Nil 2) 5) 1) 2
 Ghci> toBList [5,4,3,2,1]
  Output: Snoc (Snoc (Snoc (Snoc (Snoc Nil 5) 4) 3) 2) 1

  Ghci> cons 21 (toBList [1..2])
  Output: Snoc (Snoc (Snoc Nil 21) 1) 2
  Ghci> cons 0 (toBList [1..6]) 
  Output: Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 0) 1) 2) 3) 4) 5) 6
  Ghci> cons 21 (toBList [])
  Output: Snoc Nil 21

  Ghci> snoc [2..6] 10
  Output: [2,3,4,5,6,10]
  Ghci> snoc [2,3,4,1] 0
  Output: [2,3,4,1,0]
  Ghci> snoc [4,2,5,6,2] 43
  Output: [4,2,5,6,2,43]

  Ghci> fromBList (toBList [1..2])
  Output: [1,2]
  Ghci> fromBList (Snoc (Snoc (Snoc (Snoc (Snoc Nil 5) 4) 3) 2) 1)
  Output: [5,4,3,2,1]
  Ghci> fromBList (toBList [])
  Output: []
-}

-- 3. A binary tree data structure
treeTestOne = Node 2 (Node 132 (Node 12 (Empty) (Empty)) (Empty)) (Node 2021 (Node 3222 (Empty) (Empty)) (Empty))
treeTestTwo = Node 2 (Empty) (Empty)
treeTestThree = Node 21 (Node 211 (Empty) (Empty)) (Node 212 (Empty) (Empty))

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node a b c) = num_empties b+num_empties c

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node a b c) =num_nodes b + num_nodes c + 1 


-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left a Empty= Node a Empty Empty
insert_left a (Node b c d)= Node  b(insert_left a c)d 

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right a Empty= Node a Empty Empty
insert_right a (Node b c d)= Node b c(insert_right a d)

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty=0
sum_nodes (Node a b c)= a+ sum_nodes b + sum_nodes c 

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty=[]
inorder (Node a Empty empty)= [a]
inorder (Node a b c)= inorder b ++ [a] ++inorder c

{-
Ghci> num_empties treeTestOne
  Output: 6
 Ghci> num_empties treeTestTwo
  Output: 2
  Ghci> num_empties treeTestThree
  Output: 4

  Ghci> num_nodes treeTestOne
  Output: 5
 Ghci> num_nodes treeTestTwo
  Output: 1
  Ghci> num_nodes treeTestThree
  Output: 3

  Ghci> insert_left 12 treeTestOne
  Output: Node 21 (Node 22 (Node 12 (Node 123 Empty Empty) Empty) Empty) (Node 2121 (Node 3232 Empty Empty) Empty)
 Ghci> insert_left 12 treeTestTwo
  Output: Node 21 (Node 12 Empty Empty) Empty
  Ghci> insert_left 123 treeTestThree
  Output: Node 21 (Node 21 (Node 12 Empty Empty) Empty) (Node 212 Empty Empty)

  Ghci> insert_right 123 treeTestOne
  Output: Node 21 (Node 21 (Node 123 Empty Empty) (Node 3232 Empty Empty)) (Node 212 (Node 12 Empty Empty) Empty)
  Ghci> insert_right 123 treeTestTwo
  Output: Node 21 (Node 123 Empty Empty) Empty
  Ghci> insert_right 123 treeTestThree
  Output: Node 21 (Node 212 (Node 123 Empty Empty) Empty) (Node 211 Empty Empty)

  Ghci> sum_nodes treeTestOne
  Output: 5598
  Ghci> sum_nodes treeTestTwo
  Output: 21
  Ghci> sum_nodes treeTestThree
  Output: 444

  Ghci> inorder treeTestOne
  Output: [12,212,21,3232,2121]
  Ghci> inorder treeTestTwo
  Output: [21]
  Ghci> inorder treeTestThree
  Output: [211,21,212]Output: 
-}

-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf a)=1
num_elts (Node2 a b c)= 1 + num_elts b + num_elts c 


-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf a) = a
sum_nodes2 (Node2 a b c)= a+ sum_nodes2 b+ sum_nodes2 c


-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf a)=[a]
inorder2 (Node2 a b c)=inorder2 b ++[a] ++inorder2 c

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf a)= Node a Empty Empty 
conv21 (Node2 a b c)= Node a (conv21 b) (conv21 c)
{-
*Main> sum_nodes2 leafTree1
  Output: 56
  *Main> sum_nodes2 leafTree2
  Output: 63
  *Main> sum_nodes2 leafTree3
  Output: 5099

  *Main> inorder2 leafTree1
  Output: [10,12,13]
  *Main> inorder2 leafTree2
  Output: [16,26,22]
  *Main> inorder2 leafTree3
  Output: [10,19,4,31,21,21,101,322,112,232,13]

  *Main> conv21 leafTree1
  Output: Node 21 (Node 12 Empty Empty) (Node 23 Empty Empty)
  *Main> conv21 leafTree2
  Output: Node 21 (Node 21 Empty Empty) (Node 21 Empty Empty)
  *Main> conv21 leafTree3
  Output: Node 21 (Node 301 (Node 19 (Node 20 Empty Empty) (Node 4 Empty Empty)) (Node 211 Empty Empty)) (Node 362 (Node 4202 (Node 1034 Empty Empty) (Node 412 Empty Empty)) (Node 13 Empty Empty))
-}

---- Part 2: Iteration and Accumulators ----------------
leafTree1 = Node2 2 (Leaf 12) (Leaf 22)
leafTree2 = Node2 2 (Leaf 21) (Leaf 19)
leafTree3 = Node2 2 (Node2 32 (Node2 17 (Leaf 20) (Leaf 4)) (Leaf 211)) (Node2 362 (Node2 402 (Leaf 124) (Leaf 449)) (Leaf 13))

-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' x= toBList_it x where
  toBList_it :: [a]->BList a
  toBList_it []=Nil
  toBList_it (x:xs)= cons x(toBList_it xs)

fromBList' :: BList a -> [a]
fromBList' x = fromBList_it x where
  fromBList_it :: BList a->[a]
  fromBList_it Nil = []
  fromBList_it (Snoc Nil a)=[a]
  fromBList_it (Snoc b a) = snoc (fromBList_it b)a


-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] a = a
  sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
  sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' t = nmties [t] 0 where
  nmties [] a=a
  nmties (Empty:ts) a= nmties ts (a+1)
  nmties (Node n t1 t2:ts) a=nmties (t1:t2:ts) a

num_nodes' :: Tree a -> Int
num_nodes' t = num_nodes_it [t] 0 where
  num_nodes_it [] a =a
  num_nodes_it (Empty:ts) a=num_nodes_it ts a
  num_nodes_it (Node n t1 t2:ts) a = num_nodes_it (t1:t2:ts) (a+1)
{-
*Main> inorder2' leafTree1
  Output: [12,21,23]
  *Main> inorder2' leafTree2
  Output: [21,21,21]
  *Main> inorder2' leafTree3
  Output: [20,19,4,321,211,21,1234,4212,512,332,13]
-}


-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' t = inord [t] [] where
  inord [] a=a
  inord (Leaf x:ts) a = x:inord ts a
  inord (Node2 n t1 t2:ts) a= inord [t1] a++[n]++inord (t2:ts) a




---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map f []=[]
my_map f(x:xs)= f x: my_map f xs
--ghci> map (+1) [1,2,3]
--[2,3,4]

my_all :: (a -> Bool) -> [a] -> Bool
my_all f []=True 
my_all f (x:xs)= f x && (my_all f xs)
--ghci> all (==1) [1,1,0,1,1]
--False
--ghci> all (<10) [1,3,5,7,9]
--True
my_any :: (a -> Bool) -> [a] -> Bool
my_any f [] = False
my_any f (x:xs) = f x || (my_any f xs) 
--ghci> any (>10) [1,3,5,7,9]
--False
--ghci> any (>10) [1,3,5,7,11]
--True
my_filter :: (a -> Bool) -> [a] -> [a]
my_filter f []=[]
my_filter f (x:xs)= if f x then x:(my_filter f xs)
else my_filter f xs 
--filter (>3) [1,5,3,2,1,6,4,3,2,1]  
--[5,6,4]

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile f []= []
my_dropWhile f (x:xs)=if f x then my_dropWhile f xs
else (x:xs)
--dropWhile (<3) [1,2,3,4,5]
--[3,4,5]
my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile f []= []
my_takeWhile f (x:xs)= if f x then x:my_takeWhile f xs
else []
--ghci> takeWhile (<3) [1,2,3,4,5]
--[1,2]

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break f []=([],[])
my_break f l=(first,second) where
  first =bhelper f l
  second=bhelper2 f l     where
  bhelper f []=[]
  bhelper f (x:xs)=if not(f x) then x:bhelper f xs else []
  bhelper2 f []=[]
  bhelper2 f (x:xs)= if f x then (x:xs) else bhelper2 f xs
  --ghci> my_break (3==) [1,2,3,4,5]
--([1,2],[3,4,5])

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and =foldr (&&) True

my_or :: [Bool] -> Bool
my_or = foldr (||) False 

my_concat :: [[a]] -> [a]
my_concat = foldr (++) []
{-ghci> my_and [True,True,False,True]    
False
ghci> my_or [True,True,False,True]
True
ghci> my_concat [[1,2,3], [1,2,3]]
[1,2,3,1,2,3]
-}

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum = foldl (+) 0 

my_product :: Num a => [a] -> a
my_product = foldl (*) 1 

my_reverse :: [a] -> [a]
my_reverse [] = []
my_reverse xs = foldl (\a x-> x : a) [] xs

{-
ghci> my_sum [12,4,6,8]
30
ghci> my_product [1,23,4,5]
460
ghci> my_reverse [1,23,4,5]
[5,4,23,1]
-}

---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
all_child_leaves :: Tree a ->Bool
all_child_leaves (Node a Empty Empty)= True
all_child_leaves Empty=False 
all_child_leaves (Node a Empty c)=False
all_child_leaves(Node a b Empty)=False
all_child_leaves(Node a b c)= all_child_leaves b && all_child_leaves c

conv12 :: Tree a -> Maybe (Tree2 a)
conv12 Empty = Nothing
conv12 (Node a Empty Empty)= Just (Leaf a)
conv12 (Node a Empty b)=Nothing
conv12 (Node a b Empty)=Nothing
conv12 (Node a b c)= Just (Node2 a (conv b) (conv c)) where
  conv (Node a Empty Empty)= Leaf a
  conv (Node a b c)=Node2 a (conv b) (conv c)



-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst Empty=True
bst (Node a Empty Empty)=True
bst (Node a b c)= bsth b a == LT && bsth c a ==GT && bst b && bst c where
  bsth Empty x= GT
  bsth (Node a b c) x=compare a x 
    
bst2 :: Tree2 Int -> Bool
bst2 (Leaf a)= True
bst2 (Node2 a b c)= bst2h b a==LT && bst2h c a == GT && bst2 b && bst2 c where
  bst2h (Leaf a) x=compare a x 
  bst2h (Node2 a b c) x= compare a x

