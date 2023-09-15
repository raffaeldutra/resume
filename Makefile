CFLAGS=-s

current_dir := $(shell pwd)
SHELL := /bin/bash
.DEFAULT_GOAL := help

# How many spaces do you want to create CLI output for yous commands when typed the `make` command.
# To change on CLI at runtime, use: make SPACES=20
SPACES ?= 10

# Specify default language to be used to create the pdf file.
# In you want to change the default language, you can pass a different value through CLI.
lang ?= english

# Color values
RED := 31m
GREEN := 32m
YELLOW := 33m
BLUE := 34m
MAGENTA := 35m
CYAN := 36m
WHITE := "37m"

# Change the color output for help menu
HELP_COMMAND_COLOR = $(RED)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[$(HELP_COMMAND_COLOR)%-$(SPACES)s\033[0m %s\n", $$1, $$2}'

.PHONY: pdf
pdf:
	docker container run \
	--workdir /tmp \
	--volume ./:/tmp \
	raffaeldutra/pdflatex:1.0 pdflatex \
	-output-directory=/tmp \
	-jobname=rafael_dutra \
	"\def\lang{$(lang)} \
	\input{main}" \
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
