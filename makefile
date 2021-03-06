CFLAGS=-Wall -Wfloat-equal -Weffc++ -Wold-style-cast -Woverloaded-virtual -Wshadow -Wpointer-arith -Wcast-align -Wsign-compare -Winline --pedantic -pipe -I./include
LDFLAGS=-lc -lglut -lGLU -lGL -lXmu -lXext -lX11 -lm -lpthread
# -O3 is NOT safe with gcc 4.x
# no risk no fun ;)
RELEASE=-O3 -march=native
DEBUG=-g -DDEBUG
SOURCE=$(wildcard src/*.cpp)
OBJECTS:= $(patsubst %.cpp,%.o,$(SOURCE))

all : $(OBJECTS)
	g++ $(LDFLAGS) $(OBJECTS) -o sogo

release : override CFLAGS+=$(RELEASE) -DSCHROTTI
release : clean all;

schrotti : override CFLAGS+=$(RELEASE) -DSCHROTTI
schrotti : clean all;

debug : override CFLAGS+=$(DEBUG) 
debug : clean all;

asm : override CFLAGS+=-S
asm : clean all;

clean :
	rm -f src/sogo $(OBJECTS)

%.o : %.cpp
	g++ -c $(CFLAGS) $< -o $@

