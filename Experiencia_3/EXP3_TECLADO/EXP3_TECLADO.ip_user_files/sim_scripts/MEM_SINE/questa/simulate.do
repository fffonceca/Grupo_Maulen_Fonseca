onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib MEM_SINE_opt

do {wave.do}

view wave
view structure
view signals

do {MEM_SINE.udo}

run -all

quit -force
