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
	-jobname=rafael_dutra \
	main.tex

.PHONY: cl
cl: ## Create Cover Letter with a little help of variables that can be passed via CLI.
	docker container run \
	--workdir /tmp \
	--volume ./:/tmp \
	raffaeldutra/pdflatex:1.0 pdflatex \
	-output-directory=/tmp \
	-jobname=rafael_dutra_cover_letter \
	"\def\currentCompany{$(currentCompany)} \
	 \def\currentPosition{$(currentPosition)} \
	 \def\desiredPosition{$(desiredPosition)} \
	 \def\desiredCompany{$(desiredCompany)} \
	 \input{cover_letter}" \
	cover_letter.tex

.PHONY: build
build:
	docker image build \
	--tag raffaeldutra/pdflatex:1.0 .
