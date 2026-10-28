-- Week 3 — Lists: building blocks, built-in tools, recursion
--
-- Replace every `undefined` with your solution.
--
-- How to test:
--   runghc  Remove the "-- " in front of ONE "main = print ..." line, save the file,
--           and run   runghc demo.hs   in the terminal.
--           The value after the last "--" on that line is the expected output.
--           Only one main can be active at a time.
--   GHCi    Run   ghci demo.hs   and type any expression, e.g. the part inside print ( ).
--           After editing the file, type  :r  to reload it.

------------------------------------------------------------------------
-- Part 1. What is a list? (in GHCi)
------------------------------------------------------------------------
--   [1, 2, 3]
--   :t [True, False]
--   :t "hello"
--   "hi" == ['h', 'i']
--   :t [[1, 2], [3]]
--   [1, True]
--
--   [1..10]
--   [2, 4 .. 20]
--   [10, 9 .. 1]
--   ['a' .. 'f']
--   [10 .. 1]
--   take 5 [1 ..]
--
--   1 : [2, 3]
--   1 : 2 : 3 : []
--   [1, 2] ++ [3, 4]
--   "abc" !! 0

-- 1.1 The sum of the numbers from 1 to n.   (Week 2: four lines of recursion.)
sumTo :: Int -> Int
sumTo n = sum [1..n]
-- main = print (sumTo 100)  -- 5050
-- main = print (sumTo 0)    -- 0

-- 1.2 The even numbers from 2 up to n.
evensUpTo :: Int -> [Int]
evensUpTo n = [2,4..n]
-- main = print (evensUpTo 10)  -- [2,4,6,8,10]
-- main = print (evensUpTo 7)   -- [2,4,6]

-- 1.3 A countdown from n to 1.
countdown :: Int -> [Int]
countdown n = [n, n - 1 .. 1]
-- main = print (countdown 5)  -- [5,4,3,2,1]
-- main = print (countdown 0)  -- []

-- 1.4 The letters of the alphabet from a given letter to 'z'. (optional)
lettersFrom :: Char -> String
lettersFrom c = [c..'z']
-- main = print (lettersFrom 'w')  -- "wxyz"

------------------------------------------------------------------------
-- Part 2. Built-in list tools
------------------------------------------------------------------------
-- Predict:
-- head [3,1,4,1,5]         tail [3,1,4,1,5]        last [3,1,4,1,5]       init [3,1,4,1,5]
-- length [3,1,4,1,5]       reverse [3,1,4,1,5]     [3,1,4,1,5] !! 2
-- take 2 [3,1,4,1,5]       drop 2 [3,1,4,1,5]      take 10 [1,2]          drop 10 [1,2]
-- elem 4 [3,1,4,1,5]       sum [3,1,4,1,5]         product [3,1,4,1,5]
-- maximum [3,1,4,1,5]      minimum [3,1,4,1,5]     null []
-- concat [[1,2],[3],[]]    replicate 3 'x'         words "hi there  you"  unwords ["a","b"]
--   head []

-- 2.1 Move the first element to the end of the list. (The list is not empty.)
-- rotate :: [Int] -> [Int]
-- rotate list = tail list ++ [head list]
-- main = print (rotate [1,2,3])  -- [2,3,1]
-- main = print (rotate [7])      -- [7]

-- 2.2 Is a word a palindrome (the same forwards and backwards)?
isPalindrome :: String -> Bool
isPalindrome w = w == reverse w
-- main = print (isPalindrome "racecar")  -- True
-- main = print (isPalindrome "haskell")  -- False

-- 2.3 The middle element of a non-empty list. For an even length, take the right one of the two middles.
middle :: [Int] -> Int
middle list = list !! (div (length list) 2)
-- main = print (middle [1,2,3,4,5])  -- 3
-- main = print (middle [1,2,3,4])    -- 3

-- 2.4 Remove the element at position i (positions start at 0).
removeAt :: Int -> [Int] -> [Int]
removeAt i list = take i list ++ drop (i + 1) list
-- main = print (removeAt 2 [10,20,30,40])  -- [10,20,40]
-- main = print (removeAt 0 [10,20,30])     -- [20,30]
-- main = print (removeAt 9 [10,20,30])     -- [10,20,30]

-- 2.5 Split a list into two halves.
halves :: [Int] -> [[Int]]
halves list = [take middle list, drop middle list]
  where
    middle = div (length list) 2
-- main = print (halves [1,2,3,4,5])  -- [[1,2],[3,4,5]]
-- main = print (halves [])           -- [[],[]]

-- 2.6 Average of a list (0 for the empty list). (optional)
average :: [Int] -> Double
average list = fromIntegral (sum list) / fromIntegral (length list)
-- main = print (average [1,2,3,4])  -- 2.5
-- main = print (average [])         -- 0.0

-- 2.7 Is a character a vowel?   (elem works on text too: a String is a list of Char.)
isVowel :: Char -> Bool
isVowel c = elem c "aeiouy"
-- main = print (isVowel 'e')  -- True
-- main = print (isVowel 'x')  -- False

-- 2.8 Reverse the order of the words in a sentence.
reverseWords :: String -> String
reverseWords = unwords . reverse . words

-- main = print (reverseWords "one two three")  -- "three two one"

------------------------------------------------------------------------
-- Part 3. Recursion on lists
------------------------------------------------------------------------
-- A list is either empty:  []
-- or a first element in front of a (smaller) rest:  x : xs
-- (Last week: a number is its last digit + a smaller number. Same idea!)

-- 3.1 Sum of a list (without the built-in sum).
mySum :: [Int] -> Int
mySum [] = 0
-- mySum list = head list + mySum (tail list)
mySum (x:xs) = x + mySum xs

-- main = print (mySum [1,2,3])  -- 6
-- main = print (mySum [])       -- 0

-- 3.2 Length of a list (without the built-in length). (optional)
myLength :: [Int] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs
-- main = print (myLength [5,5,5,5])  -- 4
-- main = print (myLength [])         -- 0

-- 3.3 How many even numbers are in the list?
countEven :: [Int] -> Int
countEven [] = 0
countEven (x:xs) = (if even x then 1 else 0) + countEven xs
-- main = print (countEven [1,2,3,4,6])  -- 3
-- main = print (countEven [1,3])        -- 0

-- 3.4 Double every element.
doubleAll :: [Int] -> [Int]
doubleAll [] = []
doubleAll (x:xs) = x * 2 : doubleAll xs
-- main = print (doubleAll [1,2,3])  -- [2,4,6]
-- main = print (doubleAll [])       -- []

-- 3.5 Keep only the positive numbers.
keepPositive :: [Int] -> [Int]
keepPositive [] = []
keepPositive (x:xs) = (if x > 0 then [x] else []) ++ keepPositive xs
-- main = print (keepPositive [3,-1,0,5,-2])  -- [3,5]
-- main = print (keepPositive [-1,-2])        -- []

-- 3.6 The elements before the first 0.
beforeZero :: [Int] -> [Int]
beforeZero [] = []
beforeZero (x:xs)
  | x == 0 = []
  | otherwise = x : beforeZero xs
-- main = print (beforeZero [4,2,0,7,0])  -- [4,2]
-- main = print (beforeZero [1,2])        -- [1,2]
-- main = print (beforeZero [0,1])        -- []

-- 3.7 Are there two equal neighbours somewhere in the list?
hasTwins :: [Int] -> Bool
hasTwins [] = False
hasTwins [_] = False
hasTwins (x:y:xs) = if x == y then True else hasTwins (y:xs)
-- main = print (hasTwins [1,2,2,3])  -- True
-- main = print (hasTwins [1,2,1,2])  -- False
-- main = print (hasTwins [7])        -- False

-- 3.8 Sum of every sublist. (optional)
sumEach :: [[Int]] -> [Int]
sumEach [] = []
sumEach (xs:xss) = sum xs : sumEach xss
-- main = print (sumEach [[1,2],[3,4,5],[]])  -- [3,12,0]
