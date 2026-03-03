# Maze Representation, Rendering, and Solving in Haskell

## 1. Overview

This project implements a complete maze system in Haskell, including:

- Maze representation
- ASCII maze rendering
- Maze solving using Breadth-First Search (BFS)
- Performance optimization
- Alternative data structure implementations
- Benchmark comparison

The system progressively improves correctness and efficiency, culminating in multiple representations and performance analysis.

---

## 2. Maze Representation

A maze is represented as a rectangular grid of squares identified by integer coordinates:

```haskell
type Place = (Int, Int)
```

Movement is defined using four cardinal directions:

```haskell
data Direction = N | S | E | W deriving (Eq, Show)
```

Walls are represented as:

```haskell
type Wall = (Place, Direction)
```

The maze size is stored as:

```haskell
type Size = (Int, Int)
```

### Initial Representation

```haskell
data Maze = AMaze Size [Wall]
```

All walls are stored in a single list. While simple, this results in slower wall lookups during solving.

---

## 3. Maze Rendering

The function:

```haskell
drawMaze :: Maze -> IO ()
```

renders the maze in ASCII format.

The implementation:

- Iterates row by row
- Draws horizontal walls
- Draws vertical walls
- Uses `hasWall` to determine wall presence

### Example Output — Small Maze

```
ghci> drawMaze smallMaze
+---+---+---+---+
|       |   |   |
+   +---+   +   +
|           |   |
+---+   +   +   +
|       |       |
+---+---+---+---+
```

### Example Output — Impossible Maze

```
ghci> drawMaze impossibleMaze
+---+---+---+
|       |   |
+   +   +---+
|   |       |
+   +---+   +
|           |
+---+---+---+
```

This confirms correct wall detection and layout formatting.

---

## 4. Maze Solving (Breadth-First Search)

The solver returns:

```haskell
type Path = [Direction]
```

Main function:

```haskell
solveMaze :: Maze -> Place -> Place -> Path
```

Internally:

```haskell
solveMazeIter :: Maze -> Place -> [(Place, Path)] -> [Place] -> Path
```

### BFS Strategy

1. Start from the initial position
2. Explore all reachable neighbors
3. Add valid neighbors to a queue
4. Stop when the target is reached
5. Return the shortest path

If no solution exists:

```haskell
error "Maze is unsolvable!"
```

---

## 5. Correctness Tests

### Small Maze

```
ghci> solveMaze smallMaze (0,0) (3,2)
[E,N,E,S,E,N,N]
```

This confirms correct shortest-path computation.

---

### Large Maze

```
ghci> solveMaze largeMaze (0,0) (22,21)
[N,N,N,N,N,N,N,N,N,E,E,E,...]
```

The solver successfully handles large input sizes.

---

### Impossible Maze

```
ghci> solveMaze impossibleMaze (0,0) (2,2)
*** Exception: Maze is unsolvable!
```

Correct failure handling is implemented.

---

## 6. Optimization Improvements

### Problem in Initial BFS

The original implementation:

- Did not check whether nodes were already in the queue
- Revisited previously explored states
- Risked infinite loops
- Performed redundant computation

---

### Improved Solver

Enhancements include:

- Tracking visited locations
- Preventing duplicate entries in the BFS queue

```haskell
not (newPlace `elem` map fst rest)
```

This significantly improves efficiency and guarantees termination for impossible mazes.

---

## 7. Alternative Representations

### Direction-Separated Representation

Instead of storing all walls in one list:

```haskell
data Maze = AMaze Size [Place] [Place] [Place] [Place]
```

Each list corresponds to walls in a specific direction (North, South, East, West).

This reduces lookup overhead.

---

### Binary Search Tree Representation

Each directional wall list is replaced with a binary search tree.

Benefits:

- Faster wall lookups
- Improved solving speed

Trade-off:

- Increased memory usage

---

## 8. Performance Benchmarking

Using `:set +s` in GHCi:

### Original Representation

Small Maze:
```
(0.05 secs, 118,768 bytes)
```

Large Maze:
```
(0.10 secs, 2,644,128 bytes)
```

---

### Direction-Separated Representation

Small Maze:
```
(0.04 secs, 118,120 bytes)
```

Large Maze:
```
(0.06 secs, 2,526,168 bytes)
```

---

### BST Representation

Small Maze:
```
(0.01 secs, 125,416 bytes)
```

Large Maze:
```
(0.05 secs, 5,113,408 bytes)
```

---

## 9. Comparative Analysis

| Representation | Large Maze Time | Memory Usage |
|----------------|----------------|--------------|
| List-based | ~0.10s | ~2.6MB |
| Direction Lists | ~0.06s | ~2.5MB |
| BST-based | ~0.05s | ~5.1MB |

### Observations

- Separating walls by direction improves lookup time.
- Tree-based storage provides fastest execution.
- Memory usage increases with tree-based representation.
- Trade-off exists between speed and space.

---

## 10. Conclusion

This project demonstrates:

- Functional data modeling
- Recursive BFS implementation
- Efficient queue management
- State tracking for guaranteed termination
- Data structure impact on performance
- Practical benchmarking in GHCi

The final system:

- Correctly renders mazes
- Computes shortest paths
- Handles unsolvable cases
- Scales to large mazes
- Demonstrates measurable performance improvements

---

## Future Improvements

- A* search implementation
- Random maze generation
- GUI or web-based visualization
- Animated path rendering
