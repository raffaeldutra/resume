CFLAGS=-s

current_dir := $(shell pwd)
SHELL := /bin/bash

.PHONY: pdf
pdf:
	docker container run \
	--workdir /tmp \
	--volume ./:/tmp \
	raffaeldutra/pdflatex:1.0 pdflatex \
	-output-directory=/tmp \
	-jobname=rafael_dutra.pdf \
	main.tex

.PHONY: build
build:
	docker image build \
	--tag raffaeldutra/pdflatex:1.0 .
