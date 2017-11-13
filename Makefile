CC = gcc
CXX = g++
GLFLAGS = -lglew32 -lfreeglut -lopengl32 -lglu32
SQLITEFLAGS = -lsqlite3
WINFLAGS = -mwindows
CFLAGS = -O2 -march=native -Wall -static $(WINFLAGS)
CXXFLAGS = $(CFLAGS)
CSOURCES = $(wildcard *.c)
CXXSOURCES = $(wildcard *.cpp)
OBJECTS = $(CSOURCES:.c=.o) $(CXXSOURCES:.cpp=.o)
EXECUTABLE = myproject.exe

all: $(CSOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(CFLAGS)

clean:
	rm -rf *.o $(EXECUTABLE) include_tags tags

run:
	$(EXECUTABLE)

tags:
	ctags -f include_tags -R --c-kinds=+px --fields=+iaS --extra=+q \
		$$(gcc -M $(CSOURCES) $(CXXSOURCES))

.PHONY: clean tags
