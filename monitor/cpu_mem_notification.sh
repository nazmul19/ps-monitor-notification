#!/bin/bash
gnuplot ./gnu-script/cpu_plot.script
gnuplot ./gnu-script/mem_plot.script
./email/cpu_email.sh
./email/mem_email.sh
