#!/bin/bash


grep GFLOP $1 | awk '{print $NF}' > $2
