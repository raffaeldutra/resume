# Resume

Welcome to my resume. This project was created using Latex (pdflatex) to generate it.

Below the instructions to create the Docker image and run it.

## TL;DR

To create pdf file to generate resume:

First, create the image:

```bash
make build
```

Create the resume with:

```bash
make pdf
```

If you want to create Cover Letter, use `make cl`, but it needs arguments/parameters to be used:

```bash
make cl \
currentCompany="Current Company Name" \
currentPosition="Current Position" \
desiredCompany="Target Company" \
desiredPosition="Target Position"
```

Running `make` will show the output for available commands.

## Creating image manually

First, we do need generate a new image for pdflatex, and after that, we can run it.

```bash
docker image build \
--tag raffaeldutra/pdflatex:1.0 .
```

## Creating resume pdf

All files will be generated and shared within your localhost.

```bash
export lang="english" # You can change it to portuguese if needed
export cj=true        # Set this parameter to tell if you're currently working.

docker container run \
--workdir /tmp \
--volume ./:/tmp \
raffaeldutra/pdflatex:1.0 pdflatex \
-output-directory=/tmp \
-jobname=cv \ # output file created
"\def\lang{${lang}} \
\def\cj{${cj}} \
\input{main}" \
main.tex
```

## Creating cover letter pdf

The cover letter is only available in english at the moment.

```bash
export currentCompany="Current Company Name"
export currentPosition="Current Position"
export desiredCompany="Target Company"
export desiredPosition="Target Position"

docker container run \
--workdir /tmp \
--volume ./:/tmp \
raffaeldutra/pdflatex:1.0 pdflatex \
-output-directory=/tmp \
-jobname=rafael_dutra_cover_letter \
"\def\currentCompany{${currentCompany}} \
 \def\currentPosition{${currentPosition}} \
 \def\desiredPosition{${desiredPosition}} \
 \def\desiredCompany{${desiredCompany}} \
 \input{cover_letter}" \
cover_letter.tex
```

This project was build on top of project https://github.com/arasgungore/arasgungore-CV. All core functionality was built on that project. Thank you.
