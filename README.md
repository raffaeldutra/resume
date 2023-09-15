# Resume

Welcome to my resume. This project was created using Latex (pdflatex) to generate it.

Below the instructions to create the Docker image and run it.

## TL;DR

To create pdf file to generate resume:

First, create the image:

```
make build
```

Create the resume with:

```
make pdf
```

If you want to create Cover Letter, use `make cl`, but it needs arguments/parameters to be used:

```
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

## Running our container

All files will be generated and shared within your localhost.

```bash
docker container run \
--workdir /tmp \
--volume ./:/tmp \
raffaeldutra/pdflatex:1.0 pdflatex \
-output-directory=/tmp \
-jobname=cv \ # output file created
"\def\lang{$(lang)} \
\input{main}" \
main.tex
```

This project was build on top of project https://github.com/arasgungore/arasgungore-CV. All core functionality was built on that project. Thank you.
