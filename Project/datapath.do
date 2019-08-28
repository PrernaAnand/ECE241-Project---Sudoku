# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog datapath.v
vlog titleMemory.v

vlog easy_grid.v

vlog hard_grid.v

vlog vga_address_translator.v



#load simulation using mux as the top level simulation module
vsim -L altera_mf_ver datapath


#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
#add wave {/*}
add wave {/T/*}

#for clock_20?
force {clock} 0 0ns, 1 1ns -r 2ns

force {ld_move} x
force {ld_number} 4'b1001
force {ld_plot} 0
force {go} 0
 
#forcing endgame, back to title page:

force {end_game} 0
run 10ns

force {end_game} 1 
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
run 38700ns

#loading page: (should take us to title page)

force {ld_page} 1
force {ld_S_matrix} 0
force {ld_L_matrix} 0
run 38700ns

force {end_game} 1  
run 38700ns

force {end_game} 0
run 38700ns

#loading S_matrix: (this should take us to S_Matrix, which takes us to S_Matrix_Wait)

force {ld_page} 0
force {ld_S_matrix} 1
force {ld_L_matrix} 0 
run 38700ns

force {ld_S_matrix} 0
force {end_game} 1  
run 38700ns

force {ld_S_matrix} 0
force {end_game} 0
run 38700ns

#loading L matrix:

force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 1
run 38700ns

#loading DRAW
force {ld_move} x
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
force {ld_plot} 1
force {go} 0
run 38700ns

#move - y++ - 1 clock cycle
force {ld_move} 2'b00
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
force {ld_plot} 1
force {go} 0
run 1ns

#go - 1
force {ld_move} x
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
force {ld_plot} 1
force {go} 1
run 38700ns

#move - y++ - 1 clock cycle
force {ld_move} 2'b00
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
force {ld_plot} 1
force {go} 0
run 2ns

#go - 1
force {ld_move} x
force {ld_page} 0
force {ld_S_matrix} 0
force {ld_L_matrix} 0
force {ld_plot} 1
force {go} 1
run 38700ns

