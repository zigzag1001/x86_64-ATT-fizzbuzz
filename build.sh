#!/bin/bash
as program.asm -o a.o
ld a.o -o program

./program
