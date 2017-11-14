CC = gcc
GLFLAGS = -lglew32 -lfreeglut -lopengl32 -lglu32
SQLITEFLAGS = -lsqlite3
WINFLAGS = -mwindows
FLAGS = -O2 -march=native -Wall -static $(WINFLAGS)
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)
EXECUTABLE = myproject.exe

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(FLAGS)

clean:
	rm -rf *.o $(EXECUTABLE) include_tags tags

run:
	$(EXECUTABLE)

tags:
	ctags -f include_tags -R --c-kinds=+px --fields=+iaS --extra=+q \
		$$($(CC) -M $(SOURCES))

.PHONY: clean tags
