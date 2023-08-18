FROM ubuntu:22.04

RUN ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && echo "America/Sao_Paulo" > /etc/timezone \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-lang-portuguese \
    texlive-latex-recommended \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    wget \
    xzdec \
    && rm -rf /var/lib/apt/lists/*

RUN tlmgr init-usertree
# tlmgr: Local TeX Live (2021) is older than remote repository (2022).
# Cross release updates are only supported with
#   update-tlmgr-latest(.sh/.exe) --update
# See https://tug.org/texlive/upgrade.html for details.
RUN tlmgr option repository ftp://tug.org/historic/systems/texlive/2021/tlnet-final
RUN tlmgr update --self --all
RUN tlmgr install sectsty lastpage helvetic babel-portuges

CMD ["pdflatex"]
