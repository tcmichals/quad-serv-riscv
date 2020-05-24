



pcTestApp: pcTestApp.cpp Makefile udpServer.h basicProtocol.h readWriteProtocol.h
	@echo "$@" $@
	#g++ -o $@ $@.cxx -pthread -lm -Ofast -lftdi1
	g++ -o $@ $@.cpp -pthread -lm -ggdb3 -std=c++17

clean:
	rm -f pcTestApp	