FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sh -c '/bin/echo -e "no" | dpkg-reconfigure dash'
RUN dpkg-reconfigure bash


RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:deadsnakes/ppa
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:git-core/ppa
RUN apt-get update
RUN apt-get install -y sudo git

RUN apt-get update && apt-get install -y asciidoc autoconf automake autopoint bison build-essential \
chrpath cmake coreutils cpio curl cvs desktop-file-utils diffstat \
docbook-utils dos2unix doxygen flex gcc g++ gawk gcc gettext git-core gperf \
groff help2man libbz2-dev libcurl4-openssl-dev libffi-dev libfile-slurp-perl libgl1-mesa-dev libglib2.0-dev \
libglu1-mesa-dev libncurses-dev libpcre3-dev libsdl1.2-dev libsqlite3-dev libssl-dev \
libtool locales lynx-cur make meld mercurial minicom openjdk-8-jre putty \
python-argparse python-dev python-dulwich python-pexpect python-pysqlite2 \
python-svn repo rpm ruby sed subversion texi2html texinfo tofrodos transfig \
unzip vim wget xmlto xsltproc xutils-dev zlib1g-dev sudo

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

RUN apt install -y udev libev-dev libglade2-0 libglade2-dev libgudev-1.0-dev gir1.2-gudev-1.0

#Add 32bit architecture support as Realteck one builds in 32Bit environment
RUN dpkg --add-architecture i386 && apt update && apt-get -y install libc6:i386 \
libncurses5:i386 \
libstdc++6:i386

RUN mkdir -p ~/.ssh
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
