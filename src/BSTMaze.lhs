> module BSTMaze (
>   Maze,
>   makeMaze,
>   hasWall,
>   sizeOf
> ) 
> where

> import Geography
> import Data.List (sort)

Root, left subtree, right subtree. Show converts to string and Eq checks for equality. 

> data BST a = Empty
>            | Node a (BST a) (BST a)
>            deriving (Show, Eq)

> data Maze = Maze Size (BST Place) (BST Place) (BST Place) (BST Place)

Create balanced BST from sorted list

> buildBST :: [a] -> BST a   -- type 'a' generic 
> buildBST [] = Empty
> buildBST xs =
>   let mid = length xs `div` 2  -- integer division to find middle index of list 
>       (left, (x:right)) = splitAt mid xs  -- splits list xs at mid index 
>   in Node x (buildBST left) (buildBST right) -- recursively builds left and right subtrees 

Why is the following a bad implementation?

insertBST :: Ord a => a -> BST a -> BST a
insertBST x Empty = Node x Empty Empty
insertBST x Node y l r
	| x < y = Node y (insertBST x l) r
	| x > y = Node y l (insertBST x r)
	| x == y = Node y l r

buildBST' :: [a] -> BST a
buildBST' xs = foldr insertBST Empty xs



> makeMaze :: Size -> [Wall] -> Maze
> makeMaze (x, y) walls =
>   let boundaries =
>         [((0,j),   W) | j <- [0..y-1]] ++ -- westerly boundary
>         [((x-1,j), E) | j <- [0..y-1]] ++ -- easterly boundary
>         [((i,0),   S) | i <- [0..x-1]] ++ -- southerly boundary
>         [((i,y-1), N) | i <- [0..x-1]]    -- northerly boundary

Helper function filters walls in a specific direction  

>       allWalls = walls ++ boundaries ++ map reflect (walls ++ boundaries)

filters for walls where direction d matches dir and sorts the list of places to keep bst balanced 

>       buildWalls dir = buildBST (sort [p | (p, d) <- allWalls, d == dir])
>   in Maze (x, y) (buildWalls N) (buildWalls S) (buildWalls E) (buildWalls W)

> reflect :: Wall -> Wall
> reflect ((i, j), d) = (move d (i, j), opposite d)

> hasWall :: Maze -> Place -> Direction -> Bool
> hasWall (Maze _ north south east west) place dir =
>   searchBST place (head [bst | (d, bst) <- zip [N, S, E, W] [north, south, east, west], d == dir])

Search for whether a specific place has wall in a specific direction. Used by hasWall.

> searchBST :: (Ord a) => a -> BST a -> Bool
> searchBST _ Empty = False
> searchBST x (Node y left right)
>   | x == y    = True     
>   | x < y     = searchBST x left
>   | otherwise = searchBST x right

> sizeOf :: Maze -> Size
> sizeOf (Maze size _ _ _ _) = size

