TARGET = recquasim
LIBS = -lm
CC = g++
CCFLAGS = -g -Wall -Wextra -Werror -pedantic -std=c++11 -O3
CCFLAGS = -g -ansi -O3 -DNDEBUG -mavx -I/home/steven/installs/blaze-2.1

.PHONY: default all clean

default: $(TARGET)
	./$(TARGET)

all: default

OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS = $(wildcard *.h)

%.o: %.cpp $(HEADERS)
	$(CC) $(CCFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)