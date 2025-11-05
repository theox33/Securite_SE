CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2
SRC = src/main.c
BIN = bin/checkpwd

all: $(BIN)

$(BIN): $(SRC)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -rf bin

.PHONY: all clean
