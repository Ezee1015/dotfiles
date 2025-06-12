#!/bin/bash

while ! ping -c 1 -W 1 www.google.com &> /dev/null; do
    sleep 1
done
