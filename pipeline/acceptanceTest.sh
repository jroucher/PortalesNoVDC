#!/bin/bash

echo "This is a script to run on a acceptanceTest"
ls -la *
source /home/contint/workspace/vdc/portalesnovdc/venv/bin/activate
behave tests/web
