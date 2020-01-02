#!/bin/sh
for i in $(seq -w 1 20); do
    screen -dmS t-exp$i
    screen -S t-exp$i -X stuff "bash run-experiment.sh $i
"
    # (The new line is necessary, not a mistake.)
done
