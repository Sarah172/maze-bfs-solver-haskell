
> module MyMaze (
>   Maze,
>   makeMaze, 
>   hasWall,   
>   sizeOf     
> ) where

> import Geography

New Maze represenation. 

> data Maze = Maze Size [Place] [Place] [Place] [Place]


Create new maze by grouping walls by direction

> makeMaze :: Size -> [Wall] -> Maze
> makeMaze (x, y) walls =
>   let boundaries = 
>         [((0,j),   W) | j <- [0..y-1]] ++ -- westerly boundary
>         [((x-1,j), E) | j <- [0..y-1]] ++ -- easterly boundary
>         [((i,0),   S) | i <- [0..x-1]] ++ -- southern boundary
>         [((i,y-1), N) | i <- [0..x-1]]    -- northern boundary
>       allWalls = nub (walls ++ boundaries ++ map reflect (walls ++ boundaries))
>       north = [p | (p, N) <- allWalls]
>       south = [p | (p, S) <- allWalls]
>       east  = [p | (p, E) <- allWalls]
>       west  = [p | (p, W) <- allWalls]
>   in Maze (x, y) north south east west


Reflect a wall (used when adding boundary walls)

> reflect :: Wall -> Wall
> reflect ((i, j), d) = (move d (i, j), opposite d)

Checks if a wall exists in a given direction at a given place. 
Finds the list of walls for given dir by looking it up in the zip and 
returns Just walls if dir is found or Nothing if not.

> hasWall :: Maze -> Place -> Direction -> Bool
> hasWall (Maze _ north south east west) place dir =
>  case lookup dir (zip [N, S, E, W] [north, south, east, west]) of
>     Just walls -> place `elem` walls
>     Nothing    -> False


Function to return the size of the maze

> sizeOf :: Maze -> Size
> sizeOf (Maze size _ _ _ _) = size
