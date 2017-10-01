all: install test

install:
	mkdir -p Output/build
	cd Output/build; cmake ../../ && make install

test:
	mkdir -p Output/build
	cd Output/build; cmake ../../ && make test
	
clean:
	rm -rf Output
