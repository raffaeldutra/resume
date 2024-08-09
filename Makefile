CFLAGS=-s

current_dir := $(shell pwd)
SHELL := /bin/bash
.DEFAULT_GOAL := help

# How many spaces do you want to create CLI output for yous commands when typed the `make` command.
# To change on CLI at runtime, use: make SPACES=20
SPACES ?= 20

# If cj is not passed, then use the current value.
cj ?= current

# Output file name
fileName := rafael_dutra

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

LANGUAGES := \
	portuguese \
	english

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[$(HELP_COMMAND_COLOR)%-$(SPACES)s\033[0m %s\n", $$1, $$2}'

.PHONY: pdf
pdf: build ## Create resume file. make pdf lang=english
ifeq ($(lang),)
	@echo "You need to pass the argument: lang"
	@echo "usage: make pdf [ARGS]"
	@echo
	@echo "Arguments:"
	@echo "lang: Language to create pdf (default: english | portuguese)"
	@echo "Examples: make pdf lang=all"
	@echo "Examples: make pdf lang=english"
	@echo "Examples: make pdf lang=portuguese"
	@echo
	@exit 1
endif

# If lang is equal to all, then create two pdf files, one for each language.
ifeq ($(lang),all)
	@for lang in $(LANGUAGES); do \
		echo; echo "Creating pdf file for language: $$lang"; sleep 2; \
		docker container run \
		--workdir /tmp \
		--volume ./:/tmp \
		raffaeldutra/pdflatex:1.0 pdflatex \
		-output-directory=/tmp/ \
		-jobname=$(fileName)_$$lang \
		"\def\lang{$$lang} \
		\def\cj{$(cj)} \
		\input{main}" \
		main.tex; \
	done
else
	docker container run \
	--workdir /tmp \
	--volume ./:/tmp \
	raffaeldutra/pdflatex:1.0 pdflatex \
	-output-directory=/tmp \
	-jobname=$(fileName)_{$(lang)} \
	"\def\lang{$(lang)} \
	\def\cj{$(cj)} \
	\input{main}" \
	main.tex
endif

	@rm \
	*.aux \
	*.log \
	*.out

.PHONY: cl
cl: ## Create Cover Letter with a little help of variables that can be passed via CLI.
	@echo "usage: make cl [ARGS]"
	@echo
	@echo "args:"
	@echo
	@echo "currentCompany:     Current company that you are working on"
	@echo "currentPosition:    Current position that you are working on"
	@echo "desiredCompany:     Company name that you want to work"
	@echo "desiredPosition:    Position name that you want to work"
	@echo
	@echo

ifeq ($(currentCompany),)
	@echo "You need to pass the argument: currentCompany"
	@exit 1
endif

ifeq ($(currentPosition),)
	@echo "You need to pass the argument: currentPosition"
	@exit 1
endif

ifeq ($(desiredCompany),)
	@echo "You need to pass the argument: desiredCompany"
	@exit 1
endif

ifeq ($(desiredPosition),)
	@echo "You need to pass the argument: desiredPosition"
	@exit 1
endif

	docker container run \
	--workdir /tmp \
	--volume ./:/tmp \
	raffaeldutra/pdflatex:1.0 pdflatex \
	-output-directory=/tmp \
	-jobname=rafael_dutra_cover_letter_{$(lang)} \
	"\def\currentCompany{$(currentCompany)} \
	 \def\currentPosition{$(currentPosition)} \
	 \def\desiredPosition{$(desiredPosition)} \
	 \def\desiredCompany{$(desiredCompany)} \
	 \input{cover_letter}" \
	cover_letter.tex

	@rm \
	*.aux \
	*.log \
	*.out

.PHONY: build
build: ## build image
	docker image build \
	--tag raffaeldutra/pdflatex:1.0 .
