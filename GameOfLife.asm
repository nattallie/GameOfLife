// The game of life world consists of 2D grid 16x32, the grid is mapped in memory:
// RAM[100] == grid(0, 0)
// RAM[132] == grid(1, 0)
// RAM[611] == grid(15, 31)
//
// RAM[99] contains number of generations to iterate over the Game of life world (aka grid)
//
// Iteration rules:
// For a space that is 'populated':
// * Each cell with one or no neighbors dies, as if by solitude.
// * Each cell with four or more neighbors dies, as if by overpopulation.
// * Each cell with two or three neighbors survives.
//
// For a space that is 'empty' or 'unpopulated'
// * Each cell with three neighbors becomes populated.
//
// initial values are set by test. The are only two values allowed:
// 1 -- the cell is populated
// 0 -- the cell is empty

@start_state
M=0
@DRAW_START_STATE
0;JMP
(MAIN_LOOP)
    @start_state
    M=1
    @99
    M=M-1
    D=M
    @END
    D;JLT // if (M[99] < 0) JMP @END
    @100
    D=A
    @ind
    M=D
    @i
    M=0
    @j
    M=0
    (VIS_ALL)
        @ind
        D=M
        @612
        D=D-A // D = ind - 612
        @MAKE_CHANGE
        D;JEQ // if (ind - 612 == 0) JMP @MAKE_CHANGE
        @FOR_ONE_POINT
        0;JMP

(FOR_ONE_POINT)
    @cnt
    M=0 // cnt=0
    (TOP_L)
        @i
        D=M-1   // D = i - 1
        @TOP_MID   
        D;JLT   // if (i - 1 < 0) JMP @TOP_MID
        @j
        D=M-1
        @TOP_MID
        D;JLT // if (j - 1 < 0) JMP @TOP_MID
        
        @33
        D=A
        @ind
        D=M-D // D=ind-33
        @new_ind
        M=D   // new_ind=ind-33

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]
    
    (TOP_MID)
        @i
        D=M-1   // D=i-1
        @TOP_R
        D;JLT // if (i-1 < 0) JMP @TOP_R

        @32
        D=A
        @ind
        D=M-D // D=ind-32
        @new_ind
        M=D   // new_ind=ind-32

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]
    
    (TOP_R)
        @i
        D=M-1   // D=i-1
        @MID_L
        D; JLT  // if (i-1 < 0) JMP @MID_L

        @31
        D=A
        @j
        D=M-D  // D=j-31
        @MID_L
        D;JEQ  // if (j-31 == 0) JMP @MID_L

        @31
        D=A
        @ind
        D=M-D // D=ind-31
        @new_ind
        M=D   // new_ind=ind-31

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]

    (MID_L)
        @j
        D=M-1   // D=j-1
        @MID_R
        D;JLT  // if (j-1 < 0) JMP @MID_R

        @1
        D=A
        @ind
        D=M-D // D=ind-1
        @new_ind
        M=D   // new_ind=ind-1

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]
        
    (MID_R)
        @31
        D=A
        @j
        D=M-D   //D=j-31
        @BOT_L
        D;JEQ   // if (j-31 == 0) JMP @BOT_L

        @1
        D=A
        @ind
        D=M+D // D = ind + 1
        @new_ind
        M=D   // new_ind = ind + 1

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]

    (BOT_L)
        @j
        D=M-1   // D=j-1
        @BOT_M
        D;JLT  // if (j-1 < 0) JMP @BOT_M
        @15
        D=A
        @i
        D=M-D  // D=i-15
        @BOT_M
        D;JEQ  // if (i-15 == 0) JMP @BOT_M


        @31
        D=A
        @ind
        D=M+D // D = ind + 31
        @new_ind
        M=D   // new_ind = ind + 31

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]
    
    (BOT_M)
        @15
        D=A
        @i
        D=M-D  // D=i-15
        @BOT_R
        D;JEQ  // if (i-15 == 0) JMP @BOT_R

        @32
        D=A
        @ind
        D=M+D // D = ind + 32
        @new_ind
        M=D   // new_ind = ind + 32

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]

    (BOT_R)
        @15
        D=A
        @i
        D=M-D  // D=i-15
        @CHECK_ALIVE
        D;JEQ  // if (i-15 == 0) JMP @CHECK_ALIVE
        @31
        D=A
        @j
        D=M-D   //D=j-31
        @CHECK_ALIVE
        D;JEQ   // if (j-31 == 0) JMP @CHECK_ALIVE


        @33
        D=A
        @ind
        D=M+D // D = ind + 33
        @new_ind
        M=D   // new_ind = ind + 33

        @new_ind
        A=M
        D=M   // D=RAM[new_ind]
        @cnt
        M=M+D //cnt += M[new_ind]

    (CHECK_ALIVE)
        @700
        D=A
        @ind
        A=M    // A = ind
        D=A+D  // D = ind + 700
        @mapped_ind
        M=D  // mapped_ind = ind + 700
        A=D    // A=mapped_ind
        M=0    //RAM[mapped_ind] = 0

        @3
        D=A
        @cnt
        D=M-D // D = cnt - 3
        @MAKE_ALIVE
        D;JEQ // if (cnt - 3 == 0) JMP @MAKE_ALIVE
        @ind
        A=M  // A = ind
        D=M  // D = RAM[ind]
        @cnt
        M=M+D // cnt += RAM[ind]
        @3
        D=A
        @cnt
        D=M-D // D = cnt - 3
        @MAKE_ALIVE
        D;JEQ // if (cnt - 3 == 0) JMP @MAKE_ALIVE

    (POINT_END)
        @ind
        M=M+1 // ind++
        @j
        M=M+1   // j++
        @32
        D=A
        @j
        D=M-D   // D = j - 32
        @CHANGE_INDEXES
        D;JEQ  // if (j - 32 == 0) JMP @CHANGE_INDEXES 
        @VIS_ALL
        0;JMP // return to VIS_ALL

    (MAKE_ALIVE)
        @mapped_ind
        A=M   // A=mapped_ind
        M=1   // RAM[mapped_ind] = 1 
        @POINT_END
        0;JMP

(CHANGE_INDEXES)
        @i
        M=M+1
        @j
        M=0
        @VIS_ALL
        0;JMP

(DRAW_START_STATE)
    @100
    D=A
    @cur
    M=D

    @sc_i
    M=0
    @sc_j
    M=0

    (DRAW_LOOP)
        @611
        D=A
        @cur
        D=D-M   // D = 611 - cur 
        @MAIN_LOOP
        D;JLT   // if (611 - cur < 0) JMP @MAIN_LOOP
        @DRAW_SQ
        0;JMP

(MAKE_CHANGE)
    @100
    D=A
    @cur
    M=D

    @sc_i
    M=0
    @sc_j
    M=0

    @CLEAR_SCREEN
    0;JMP

    (REWRITE_LOOP)
        @611
        D=A
        @cur
        D=D-M   // D = 611 - cur 
        @MAIN_LOOP
        D;JLT   // if (611 - cur < 0) JMP @MAIN_LOOP
        @700
        D=A
        @cur
        A=M+D   // A=cur+700
        D=M     // RAM[cur+700]
        @cur
        A=M   
        M=D     // RAM[cur] = RAM[cur + 700]
        @DRAW_SQ
        0;JMP

(CLEAR_SCREEN)
    @SCREEN
    D=A
    @tmp
    M=D     // tmp = Screen base
    (LITTLE_LOOP)
        @24576
        D=A
        @tmp
        D=D-M   // D=24576 - tmp
        @REWRITE_LOOP
        D;JEQ   // if (24576 - tmp == 0) JMP @REWRITE_LOOP
        @tmp
        A=M
        M=0     //RAM[tmp]=0
        @tmp
        M=M+1   //tmp++
        @LITTLE_LOOP
        0;JMP

(DRAW_SQ)
    @cur
    A=M
    D=M     // D=RAM[cur]
    @INCREMENT_INDS
    D;JEQ   // if (RAM[cur] == 0) JMP @INCREMENT_INDS

    @sc_i
    D=M
    @cur_i
    M=D     //cur_i = sc_i

    @16
    D=A
    @k
    M=D     //k = 16 

    (INNER_LOOP)
        @k
        D=M
        @INCREMENT_INDS
        D;JEQ   // if (k == 0) JMP @INCREMENT_INDS
        @k
        M=M-1   // k--

        @SCREEN
        D=A
        @scr_ind
        M=D     // scr_ind = screen_base    

        @sc_j
        D=M
        @scr_ind
        M=M+D   //scr_ind += sc_j

        @cur_i
        D=M
        @scr_ind
        M=M+D   // scr_ind += r*32
        
        @scr_ind
        A=M
        D=0
        M=!D    // RAM[scr_ind] = 2^15

        @32
        D=A
        @cur_i
        M=M+D   // cur_i += 32

        @INNER_LOOP
        0;JMP

(INCREMENT_INDS)
    @cur
    M=M+1   //cur++
    @sc_j
    M=M+1   //sc_j++
    @32
    D=A
    @sc_j
    D=M-D   // D=sc_j-32
    @NEW_ROW
    D;JEQ  // if (sc_j - 32 == 0) JMP @NEW_ROW
    @start_state
    D=M
    @DRAW_LOOP
    D;JEQ
    @REWRITE_LOOP
    0;JMP

(NEW_ROW)
    @sc_j
    M=0     //sc_j = 0
    @512
    D=A
    @sc_i
    M=M+D   //sc_i += 512 (16 new row in terms of screen)
    @start_state
    D=M
    @DRAW_LOOP
    D;JEQ
    @REWRITE_LOOP
    0;JMP


(END) // the end of the whole program
    @END
    0;JMP
