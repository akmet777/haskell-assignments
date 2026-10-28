-- Week 3 — In-class tasks
--
-- Replace every `undefined` with your solution.
--
-- How to test:
--   runghc  Remove the "-- " in front of ONE "main = print ..." line, save the file,
--           and run   runghc tasks.hs   in the terminal.
--           The value after the last "--" on that line is the expected output.
--           Only one main can be active at a time.
--   GHCi    Run   ghci tasks.hs   and type any expression, e.g. the part inside print ( ).
--           After editing the file, type  :r  to reload it.

-- From the demo, you may use it:
removeAt :: Int -> [Int] -> [Int]
removeAt i xs = take i xs ++ drop (i + 1) xs

------------------------------------------------------------------------
-- Task 1
-- Return the first and the last element of a (non-empty) list, as a list.
------------------------------------------------------------------------

firstLast :: [Int] -> [Int]
firstLast xs = take 1 xs ++ drop (length xs - 1) xs

-- main = print (firstLast [1,2,3,4])  -- [1,4]
-- main = print (firstLast [7])        -- [7,7]

------------------------------------------------------------------------
-- Task 2
-- How many times does x occur in the list? without using function
------------------------------------------------------------------------

countOcc :: Int -> [Int] -> Int
countOcc x xs = length [() | y <- xs, y == x]

-- main = print (countOcc 3 [1,3,2,3,3])  -- 3
-- main = print (countOcc 9 [1,2])        -- 0
-- main = print (countOcc 1 [])           -- 0

------------------------------------------------------------------------
-- Task 3
-- Replace every occurrence of old with new.
------------------------------------------------------------------------

replaceAll :: Int -> Int -> [Int] -> [Int]
replaceAll old new xs = [if x == old then new else x | x <- xs]

-- main = print (replaceAll 3 9 [1,3,2,3])  -- [1,9,2,9]
-- main = print (replaceAll 7 0 [1,2])      -- [1,2]
-- main = print (replaceAll 0 1 [0,0])      -- [1,1]

------------------------------------------------------------------------
-- Task 4
-- Remove the middle element of every sublist.
-- For an even length, remove the right one of the two middles.
------------------------------------------------------------------------

removeSubMid :: [[Int]] -> [[Int]]
removeSubMid xss = [removeAt (length xs `div` 2) xs | xs <- xss]

-- main = print (removeSubMid [[1,2,3,4,5],[3],[3,4],[]])  -- [[1,2,4,5],[],[3],[]]
-- main = print (removeSubMid [[1,2,3,4,5,6,7,8]])         -- [[1,2,3,4,6,7,8]]

------------------------------------------------------------------------

------------------------------------------------------------------------
-- Task 5
-- How many times are two neighbours equal?without using zip
--   [1,2,2,3,3,3] -> 2,2 and 3,3 and 3,3 -> 3
hasTwins :: [Int] -> Bool
hasTwins [] = False
hasTwins [_] = False
hasTwins (x:y:xs) = if x == y then True else hasTwins (y:xs)


countTwins :: [Int] -> Int
countTwins xs = length [() | i <- [0..length xs - 2], hasTwins (take 2 (drop i xs))]

-- main = print (countTwins [1,2,2,3,3,3])  -- 3
-- main = print (countTwins [1,2,3])        -- 0
-- main = print (countTwins [5])            -- 0
-- main = print (countTwins [])             -- 0

------------------------------------------------------------------------
-- Task 6 (bonus)
-- Remove repeated neighbours: keep only one element from every run of equal neighbours.
------------------------------------------------------------------------

compress :: [Int] -> [Int]
compress xs = [head ys | ys <- group xs]
  where
    group [] = []
    group (y:ys) = let (first, rest) = span (== y) ys in (y:first) : group rest

-- main = print (compress [1,1,2,2,2,1,3,3])  -- [1,2,1,3]
-- main = print (compress [5])                -- [5]
-- main = print (compress [])                 -- []
