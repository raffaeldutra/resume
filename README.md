# Resume

Welcome to my resume. This project was created using Latex (pdflatex) to generate it.

Below the instructions to create the Docker image and run it.

## Creating image

First, we do need generate a new image for pdflatex, and after that, we can run it.

```bash
docker image build \
--tag raffaeldutra/pdflatex:1.0 .
```

## Running our container

All files will be generated and shared with the local host.

```bash
docker container run \
--workdir /tmp \
--volume ./:/tmp raffaeldutra/pdflatex:1.0 pdflatex \
main.tex
```

This project was build on top of project https://github.com/arasgungore/arasgungore-CV. All core functionality was built on that project. Thank you.
