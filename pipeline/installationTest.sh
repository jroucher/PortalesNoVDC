#!/bin/bash

echo "This is a script to run on a InstallationTest"
ls -la *
pwd
source /home/contint/workspace/vdc/portalesnovdc/venv/bin/activate
behave --version
