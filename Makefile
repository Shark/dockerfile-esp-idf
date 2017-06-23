NAME = sh4rk/esp32-arduino-idf
VERSION = latest

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --force-rm .
