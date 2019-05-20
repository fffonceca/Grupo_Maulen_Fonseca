onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+MEM_SINE -L dist_mem_gen_v8_0_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.MEM_SINE xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {MEM_SINE.udo}

run -all

endsim

quit -force
