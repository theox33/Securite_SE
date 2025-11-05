.PHONY: all clean verify

all:
	./make.sh

clean:
	rm -f hello.sig hello.txt private.key public.key

verify:
	openssl pkeyutl -verify -in hello.txt -pubin -inkey public.key -sigfile hello.sig