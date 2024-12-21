onerror {quit -f}
vlib work
vlog -work work FPU_project.vo
vlog -work work FPU_project.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Divider_vlg_vec_tst
vcd file -direction FPU_project.msim.vcd
vcd add -internal Divider_vlg_vec_tst/*
vcd add -internal Divider_vlg_vec_tst/i1/*
add wave /*
run -all
