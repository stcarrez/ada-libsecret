MAKE_ARGS=

ifeq ($(BUILD),coverage)
MAKE_ARGS=-- -XSECRETADA_BUILD=coverage
endif

ifeq ($(BUILD),debug)
MAKE_ARGS=-- -XSECRETADA_BUILD=debug
endif

build:
	alr build $(MAKE_ARGS)

examples:
	cd examples && alr build $(MAKE_ARGS)

clean:
	alr clean
	rm -rf obj lib regtests/bin

test:
	cd regtests && alr build $(MAKE_ARGS)
	./regtests/bin/secret_harness

.PHONY: examples
