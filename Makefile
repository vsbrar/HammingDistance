all: install test

install:
	mkdir -p Output/build
	cd Output/build; cmake ../../ && make install

test:
	mkdir -p Output/build
	cd Output/build; cmake ../../ && make test

cmake:
	mkdir -p Output
	cd Output; \
	wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz; \
	tar xzf cmake-3.18.0.tar.gz; \
	cd cmake-3.18.0; \
	./bootstrap && make && sudo make install
.PHONY: cmake	

clean:
	rm -rf Output
.PHONY: clean
