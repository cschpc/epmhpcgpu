set terminal pngcairo  enhanced font "arial,10" fontscale 1.0 size 600, 500
set output 'output.png'


set multiplot layout 4,1 title "BabelStream with modelname (GB/s)"
set style data boxplot


set lmargin 9
unset xtics
set border 14
#set ytic 1
set key title "A100"

set xrange [-1:5]
set yrange [a100min:a100max]

plot 'file.dat' using (0):($11/1000) notitle, '' using (1):($12/1000) notitle,'' using (2):($13/1000) notitle,'' using (3):($14/1000) notitle,'' using (4):($15/1000) notitle




set border 10
set xrange [-1:5]
set key title "MI100"

set yrange [mi1001min:mi1001max]

plot 'file.dat' using (0):($1/1000) notitle, '' using (1):($2/1000) notitle,'' using (2):($3/1000) notitle,'' using (3):($4/1000) notitle


set border 10
set xtics nomirror
set xrange [-1:5]
set key title "V100"

set yrange [v100min:v100max]
set xtics ("Copy" 0, "Mul" 1, "Add" 2, "Triad" 3,"Dot" 4) scale 0.0

plot 'file.dat' using (0):($6/1000) notitle, '' using (1):($7/1000) notitle,'' using (2):($8/1000) notitle,'' using (3):($9/1000) notitle,'' using (4):($10/1000) notitle


unset key
set border 11
set xrange [-1:5]

set yrange [mi1002min:mi1002max]
set key title "MI100"

plot 'file.dat' using (4):($5/1000) notitle lt rgb "blue"

unset multiplot

