#!/bin/sh

path() {
	echo "$PATH" | tr -s ':' '\n'
}
