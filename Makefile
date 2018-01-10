CC = gcc
GLFLAGS = -lglew32 -lfreeglut -lopengl32 -lglu32
SQLITEFLAGS = -lsqlite3
WINFLAGS = -lcomctl32 -mwindows -lwinmm -lshlwapi
EXCLUDE_WARNGINS = -Wno-missing-field-initializers \
	-Wno-unused-parameter
COMMON_FLAGS = -O2 -march=native -Wall -Wextra -static
// SRC_ENCODING = -finput-charset=utf-8
SRC_ENCODING = -finput-charset=cp1251
CFLAGS = $(COMMON_FLAGS) $(SRC_ENCODING) ${EXCLUDE_WARNGINS} $(WINFLAGS)
SOURCES = $(wildcard *.c)
OBJECTS = $(SOURCES:.c=.o)
EXECUTABLE = myproject.exe

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) $(CFLAGS) -o $@

clean:
	rm -rf *.o $(EXECUTABLE) include_tags tags

run: $(EXECUTABLE)
	$(EXECUTABLE)

tags:
	ctags -f tags -R --c-kinds=+px --fields=+iaS --extra=+q \
		$$($(CC) -M $(SOURCES))

.PHONY: clean tags
