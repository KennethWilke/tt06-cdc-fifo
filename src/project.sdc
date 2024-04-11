set clk_input1 [get_port $::env(CLOCK_PORT)]
set clk_input2 [get_port $::env(CLOCK_PORT2)]

create_clock $clk_input1 -name clock_1  -period $::env(CLOCK_PERIOD)
create_clock $clk_input2 -name clock_2  -period $::env(CLOCK_PERIOD)

set input_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
set output_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

set_max_fanout $::env(MAX_FANOUT_CONSTRAINT) [current_design]
if { [info exists ::env(MAX_TRANSITION_CONSTRAINT)] } {
    set_max_transition $::env(MAX_TRANSITION_CONSTRAINT) [current_design]
}

set clk_indx1 [lsearch [all_inputs] $clk_input1]
set clk_indx2 [lsearch [all_inputs] $clk_input2]
set all_inputs_wo_clk [lreplace [lreplace [all_inputs] $clk_indx1 $clk_indx1 ""] $clk_indx2 $clk_indx2 ""]

#set rst_input [get_port resetn]
#set rst_indx [lsearch [all_inputs] $rst_input]
#set all_inputs_wo_clk_rst [lreplace $all_inputs_wo_clk $rst_indx $rst_indx ""]
set all_inputs_wo_clk_rst $all_inputs_wo_clk

# correct resetn
set_input_delay $input_delay_value  -clock [get_clocks clock_1] $all_inputs_wo_clk_rst
set_input_delay $input_delay_value  -clock [get_clocks clock_2] $all_inputs_wo_clk_rst
#set_input_delay 0.0 -clock [get_clocks $::env(CLOCK_PORT)] {resetn}
set_output_delay $output_delay_value  -clock [get_clocks clock_1] [all_outputs]
set_output_delay $output_delay_value  -clock [get_clocks clock_2] [all_outputs]

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL) $::env(SYNTH_DRIVING_CELL)
}

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL_PIN)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL_PIN) $::env(SYNTH_DRIVING_CELL_PIN)
}

set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) $all_inputs_wo_clk_rst
set_driving_cell -lib_cell $::env(SYNTH_CLK_DRIVING_CELL) -pin $::env(SYNTH_CLK_DRIVING_CELL_PIN) $clk_input1
set_driving_cell -lib_cell $::env(SYNTH_CLK_DRIVING_CELL) -pin $::env(SYNTH_CLK_DRIVING_CELL_PIN) $clk_input2

# fF -> pF
set cap_load [expr $::env(OUTPUT_CAP_LOAD) / 1000.0] 
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting clock uncertainty to: $::env(SYNTH_CLOCK_UNCERTAINTY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [get_clocks clock_1]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [get_clocks clock_2]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks clock_1]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks clock_2]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
