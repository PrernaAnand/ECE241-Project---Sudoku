# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog FSM.v
vlog titleMemory.v
vlog easy_grid.v
vlog hard_grid.v
vlog vga_address_translator.v


#load simulation using mux as the top level simulation module
vsim -L altera_mf_ver  FSM


#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#for clock_50
force {Clock} 0 0ns, 1 1ns -r 2ns

#forcing resetn (i.e endgame):

force {End_Game} 0
run 10ns

force {End_Game} 1  
force {GoEasy} 0
force {GoDifficult} 0
force {GoDraw} 0
run 38600ns

#loading page: (should take us to title page)

force {Start} 1
force {End_Game} 0
force {GoEasy} 0
force {GoDifficult} 0
force {GoDraw} 0
run 38600ns

#loading S_matrix: (this should take us to S_Matrix, which takes us to S_Matrix_Wait)

force {Start} 0
force {GoEasy} 1
force {GoDifficult} 0
force {GoDraw} 0  
run 38600ns


#go back
force {End_Game} 1  
run 100ns

force {End_Game} 0
run 100ns

force {Start} 1
force {End_Game} 0
force {GoEasy} 0
force {GoDifficult} 0
force {GoDraw} 0
run 38600ns

#loading L_matrix:

force {End_Game} 0
force {Start} 0
force {GoEasy} 0
force {GoDifficult} 1
force {GoDraw} 0  
run 38600ns

#to get to DRAW:
force {GoEasy} 0
force {GoDifficult} 0
force {GoDraw} 1
run 38600ns

#to move to S_DRAW_WAIT:
force {GoEasy} 0
force {GoDifficult} 0
force {GoDraw} 1
force {Go} 1
force {Plot}  8'h3D
 
run 38600ns

force {Plot} 0
run 100ns
 
force {End_Game} 1  
run 100ns

force {End_Game} 0
run 100ns

