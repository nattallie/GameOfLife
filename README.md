# GameOfLife

### Table of Contents
* [General](#General)
* [Initial state](#Initial-State)
* [Rules](#rules)
* [More information](#more-information)

### General
The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. It is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves. It is Turing complete and can simulate a universal constructor or any other Turing machine.

### Initial state
 The game of life world consists of 2D grid 16x32, the grid is mapped in memory:
 RAM[100] == grid(0, 0)
 RAM[132] == grid(1, 0)
 RAM[611] == grid(15, 31)

 RAM[99] contains number of generations to iterate over the Game of life world (aka grid)

### Rules
 For a space that is 'populated':
 * Each cell with one or no neighbors dies, as if by solitude.
 * Each cell with four or more neighbors dies, as if by overpopulation.
 * Each cell with two or three neighbors survives.

 For a space that is 'empty' or 'unpopulated'
 * Each cell with three neighbors becomes populated.

 initial values are set by test. The are only two values allowed:
 1 -- the cell is populated
 0 -- the cell is empty
 
 ### More information
 Visit this page for more information: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
