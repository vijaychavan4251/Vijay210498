CC = gcc
CXX = g++
GLFLAGS = -lglew32 -lfreeglut -lopengl32 -lglu32
SQLITEFLAGS = -lsqlite3
WINFLAGS = -mwindows
CFLAGS = -O2 -march=native -Wall -static $(GLFLAGS) $(WINFLAGS) $(SQLITEFLAGS)
CXXFLAGS = $(CFLAGS)
CSOURCES = $(wildcard *.c)
CXXSOURCES = $(wildcard *.cpp)
OBJECTS = $(CSOURCES:.c=.o) $(CXXSOURCES:.cpp=.o)
EXECUTABLE = myproject.exe
UpdateIncludeTags = ctags -f include_tags -R --fields=+iaS --extra=+q
MinGwIncludeDir = C:\MinGW\include
GccUpdateTags = $(UpdateIncludeTags) \
				$(MinGwIncludeDir)\GL\freeglut.h \
				$(MinGwIncludeDir)\GL\gl.h \
				$(MinGwIncludeDir)\GL\glew.h \
				$(MinGwIncludeDir)\GL\glu.h \
				$(MinGwIncludeDir)\GL\glut.h \
				$(MinGwIncludeDir)\sqlite3.h \
				$(MinGwIncludeDir)\windef.h \
				$(MinGwIncludeDir)\windows.h \
				$(MinGwIncludeDir)\winuser.h

all: $(CSOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(CFLAGS)

clean:
	rm -rf *.o $(EXECUTABLE) include_tags tags

run:
	$(EXECUTABLE)

tags:
	$(GccUpdateTags)

.PHONY: clean tags
