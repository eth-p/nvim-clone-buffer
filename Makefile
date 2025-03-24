SHELL := devenv
.SHELLFLAGS := shell --quiet -- bash -e -x -c
.ONESHELL:
.SILENT:

files = $(wildcard *.lua)

.PHONY: format
format:
	stylua lua/*.lua

.PHONY: lint
lint:
	selene lua/*.lua
