FROM ubuntu:xenial

RUN apt-get update \
 && apt-get install -y --no-install-recommends git wget ca-certificates make libncurses-dev flex bison gperf python python-serial build-essential \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN set -ex \
 && tmpdir="$(mktemp -d)" \
 && trap "rm -r \"$tmpdir\"" EXIT \
 && cd "$tmpdir" \
 && wget -O "$tmpdir"/idf.tar.gz https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz \
 && tar xf idf.tar.gz -C /usr/local/src

RUN adduser --disabled-password --uid 1000 --gecos '' core

RUN set -ex \
 && git clone https://github.com/espressif/esp-idf.git /usr/local/src/esp-idf \
 && cd /usr/local/src/esp-idf \
 && git checkout v3.0-rc1 \
 && git submodule update --init --recursive \
 && chown -R core:core /usr/local/src/esp-idf

USER core
ENV PATH /usr/local/src/xtensa-esp32-elf/bin:$PATH
ENV IDF_PATH /usr/local/src/esp-idf
