# Maze BFS Solver (Haskell)

A maze solver implemented in **Haskell** using **Breadth-First Search (BFS)** for pathfinding.

The project supports maze rendering in ASCII format, shortest-path solving, and optimized search using visited-node tracking.

---

## Features

- Maze representation using grid coordinates and walls
- ASCII maze rendering in the terminal
- Breadth-First Search (BFS) pathfinding
- Detection of unsolvable mazes
- Optimized solver avoiding repeated exploration
- Multiple maze representations for performance comparison

---

## How It Works

### Maze Model

- `Place = (Int, Int)` — grid coordinates  
- `Direction = N | S | E | W`  
- Walls represented as `(Place, Direction)`

Each move checks for walls before exploring neighboring cells.

---

### Pathfinding

The solver uses **Breadth-First Search (BFS)**:

1. Start from the initial position  
2. Explore all paths level by level  
3. Stop when the target is reached  

This guarantees the shortest valid path.

---

### Optimization

An improved version of the solver:

- Tracks visited locations
- Prevents duplicate paths in the queue
- Avoids infinite loops
- Improves performance on larger mazes

---
### Maze Rendering

<img width="166" height="113" alt="image" src="https://github.com/user-attachments/assets/7da3edd7-06f2-4630-aeea-fe2bde57ebac" />

### Solver Example

haskell:
solveMaze smallMaze (0,0) (3,2)
[E,N,E,S,E,N,N]
---- 
### Running the Project

ghci Main.lhs 

Eaxample commands: 

drawMaze smallMaze
solveMaze smallMaze (0,0)(3,2)

----

## 📄 Documentation

For detailed implementation notes, performance analysis, and design decisions, see [REPORT.md](REPORT.md).

