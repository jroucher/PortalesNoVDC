#!/bin/bash

echo "This is a script to run on a acceptanceTest"
ls -la *
source venv/bin/activate
behave tests/web
