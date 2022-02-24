set terminal pngcairo  enhanced font "arial,10" fontscale 1.0 size 600, 400
set output 'output.png'


set multiplot layout 2,1 title "miniBUDE with modelname (GFLOP/s SP)"
set style data boxplot
#set ylabel "MB/s"


set lmargin 9
unset xtics
set border 14
set xrange [-1:3]
set yrange [allmin:allmax]

plot 'file.dat' using (0):1 notitle lt rgb "orange-red", '' using ( 2):3 notitle lt rgb "dark-orange"



set border 11
#set ytic 1

set xrange [-1:3]
set yrange [dotmin:dotmax]

set xtics nomirror
set xtics ("AMD MI100" 0, "NVIDIA V100" 1, "NVIDIA A100" 2) scale 0.0
plot 'file.dat' using (1):2 notitle lt rgb "dark-green"

unset multiplot

