# Haskell Guide for Week 3 Homework

A guide to the Haskell concepts and syntax you need for this homework — no answers, just the tools.

## Core ideas of Haskell

1. **Everything is an expression.** There are no statements or loops. A function body is one expression that evaluates to the result. `if ... then ... else ...` always has both branches and returns a value.
2. **Immutability.** You never modify a list — you build a *new* one.
3. **Recursion replaces loops.** To process a list, you handle the empty case and the "one element + rest" case.
4. **Strong static types.** Every function has a type signature like `factorial :: Int -> Int` (takes an `Int`, returns an `Int`). `[Int] -> [Int]` means list of Ints in, list of Ints out.

## Syntax you'll need

### Function definition and application

```haskell
f x y = x + y        -- definition: no parentheses, no commas
f 3 5                -- application: just spaces → 8
f (3 + 1) 5          -- parentheses only to group
```

Important: `drop(length xs - 2) xs` works, but idiomatic style is `drop (length xs - 2) xs` — the parens group the argument, they are not "call syntax".

### Infix operators and backticks

Functions like `mod` and `div` are normal functions: `mod 7 2`. To write them between arguments you need **backticks**:

```haskell
7 `mod` 2 == 1       -- correct
length xs `mod` 2    -- how to check even/odd length
```

`length xs mod 2` is a syntax error — Haskell reads it as the function `length` applied to three arguments. You need `` length xs `mod` 2 `` (and watch precedence: that parses as ``(length xs) `mod` 2``, which is what you want).

### Lists

```haskell
[1,2,3]              -- list literal
1 : [2,3]            -- (:) "cons" prepends an element → [1,2,3]
[1,2] ++ [3,4]       -- (++) concatenates two lists → [1,2,3,4]
""                   -- String is just [Char], so "ab" == ['a','b']
```

### Ranges (Part A)

```haskell
[1..5]               -- [1,2,3,4,5]
[2,4..10]            -- step of 2: [2,4,6,8,10]
[5..4]               -- []  (empty when start > end)
```

### Useful built-ins (Part A says no recursion — use these)

- `length`, `take n xs`, `drop n xs`, `head`, `last`, `init`, `tail`, `reverse`
- `product`, `sum` — multiply/add all elements of a list
- `words "a b  c"` → `["a","b","c"]` (splits on whitespace), `unwords` does the reverse
- `replicate n x` → list of n copies of x
- `concat` — flatten a list of lists

### Pattern matching (Part B, the key tool)

You can write multiple equations; the first matching pattern wins:

```haskell
f []       = ...     -- empty list case
f (x:xs)   = ...     -- x = first element, xs = rest of the list
f [a,b,c]  = ...     -- matches exactly a 3-element list (hint for A8)
f (x:y:rest) = ...   -- matches lists with at least 2 elements (hint for B9)
```

### Recursion pattern

Nearly every Part B task follows this skeleton:

```haskell
g []     = <base answer>              -- what is the result for an empty list?
g (x:xs) = <combine x with> (g xs)    -- do something with x, recurse on the rest
```

Ask yourself two questions per task: *what's the answer for `[]`?* and *given the answer for `xs`, how do I use `x` to build the answer for `x:xs`?*

### Guards (conditions in equations)

Nicer than nested if/else:

```haskell
f (x:xs)
  | x < 0     = ...
  | otherwise = ...
```

### Misc you'll likely need

- `even x`, `odd x` — Bool tests
- `&&`, `||`, `not` — Bool operators
- Comparisons: `==`, `/=` (not equal!), `<`, `>=`
- Negative numbers in expressions often need parens: `f (-2)`
- Recursion with an accumulator (hint for B11): pass an extra argument carrying "the best so far" in a helper function, e.g. `go acc (x:xs) = ...`
- Recursion on **two** lists at once (B12, B13): pattern match on both, e.g. `f (x:xs) (y:ys) = ...`, plus cases where either list is `[]`.

### Testing

Uncomment exactly one `main = print ...` line, then run `runghc homework.hs`. Or run `ghci homework.hs` and type expressions directly (`:r` reloads after edits) — GHCi is faster for experimenting.

### Tip for A6

Think about splitting the list into two halves with `take` and `drop`, then gluing them with `++` and the element in between.
