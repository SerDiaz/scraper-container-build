FROM selenium/standalone-chrome

#====================================
# Scripts to run Selenium Standalone
#====================================
#COPY entry_point.sh /opt/bin/entry_point.sh

USER root

# ARG GECKODRIVER_VERSION=0.19.1
ARG CHROMEDRIVER_VERSION=88.0.4324.96

# ======================
#  Install
# ======================
RUN set -ex \
    && buildDeps='                          \
        python-dev                          \
        libkrb5-dev                         \
        libsasl2-dev                        \
        libssl-dev                          \
        libffi-dev                          \
        build-essential                     \
        libblas-dev                         \
        liblapack-dev                       \
        libpq-dev                           \
        git                                 \
        libpython2-dev                      \
        libsasl2-dev                        \
        libsasl2-modules-gssapi-heimdal     \
        libsvn-dev                          \
        libtool                             \
        libapparmor-dev                     \
        libdevmapper-dev                    \
        libglib2.0-dev                      \
        libseccomp-dev                      \
        libselinux1-dev                     \
    '

RUN apt-get -y -qq update                   \
    && apt-get -y install software-properties-common  \
    $buildDeps                              \
    make                                    \
    unzip                                   \
    python3-pip                             \
    python3.8                               \
    postgresql             

RUN  apt-get install -yqq --no-install-recommends  \
    autoconf                                \ 
    automake                                \
    build-essential                         \
    ca-certificates                         \
    g++                                     \
    gdb                                     

RUN apt-get install -yqq --no-install-recommends  \
  git-core                                  \
  heimdal-clients                           \
  libapr1-dev                               \
  libboost-dev                              \
  libcurl4-nss-dev                          \
  libgoogle-glog-dev                        \
  libprotobuf-dev                         


RUN apt-get -y -qq update                   


#RUN python -m pip install -U pip          \
RUN pip3 install scrapy                   \
    && pip3 install nltk                  \ 
    && pip3 install xlrd                  \
    && pip3 install googlemaps            \
    && pip3 install jupyterlab            \ 
    && pip3 install beautifulsoup4        \
    && pip3 install insta-scrape          \                 
    && apt-get remove --purge -yqq $buildDeps \
    && apt-get clean                      \
    && rm -rf                             \
        /var/lib/apt/lists/*              \
        /tmp/*                            \
        /var/tmp/*                        \
        /usr/share/man                    \
        /usr/share/doc                    \
        /usr/share/doc-base

 
# ===============
# Chromedriver
#================
RUN wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip  \
    && mv chromedriver /usr/local/bin/ \
    && export PATH=$PATH:/usr/local/bin/chromedriver

# ===============
# Chrome
# ==============
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install ./google-chrome-stable_current_amd64.deb \
    && rm ./google-chrome-stable_current_amd64.deb

RUN pip3 install pip install notebook \
    && pip3 install selenium

USER seluser

