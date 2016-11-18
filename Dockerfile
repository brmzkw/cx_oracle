FROM ubuntu

RUN apt-get update && apt-get install -y \
    wget \
    python \
    python-setuptools

# The `pip` packages by Ubuntu is borken in many ways. Install an up to date
# version with easy_install instead.
RUN easy_install pip

# System dependencies required by cx_Oracle.
RUN apt-get install -y \
    gcc \
    python-dev \
    libaio-dev

# Binaries downloaded from
# http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html, then
# converted with `alien -d *.rpm`.
WORKDIR /tmp
RUN wget -q https://github.com/brmzkw/cx_oracle/releases/download/oracle-instantclient12.1/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb
RUN wget -q https://github.com/brmzkw/cx_oracle/releases/download/oracle-instantclient12.1/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb
RUN wget -q https://github.com/brmzkw/cx_oracle/releases/download/oracle-instantclient12.1/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb
RUN dpkg -i /tmp/*.deb
RUN rm -rf /tmp/*.deb

# Yeah, system dependencies are installed so it should work now :-)
RUN pip install cx_Oracle
