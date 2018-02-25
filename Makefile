NAME = sh4rk/esp-idf
VERSION = latest

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --force-rm .
