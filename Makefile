# -!- Makefile -!-
# generic Makefile template to start new C++ projects
# place your hpp and cpp files into the src directory
# object files will be placed within build directory
# application will be in the root folder
# to compile the example application just write into your terminal:
# 
#    make prog
VERSION   := 0.0.1
CC        := g++
SRC_DIR   := src
BUILD_DIR := build
SRCS      := $(wildcard $(SRC_DIR)/*.cpp)
HDRS      := $(wildcard $(SRC_DIR)/*.hpp)
OBJS      := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))
CFLAGS    := -I. -O3 -Wall -std=c++17
LFLAGS    :=  # -lfmt -lncurses
FORMATTER := astyle --indent=spaces=4 --mode=c 
LINTER    := cpplint

TARGET=prog

.PHONY=clean

default:
	@echo "targets:"
	@echo "  $(TARGET)      - the application"
	@echo "  format    - formatting the source code with astyle"
	@echo "  lint      - linting the source code with cppcheck"	
	@echo "  clean     - remove all build/*.o files and $(TARGET) application"

$(TARGET): $(OBJS) 
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LFLAGS)
	strip $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp  $(HDRS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $@	

lint:
	$(LINTER) $(SRCS) $(HDRS)

format:
	$(FORMATTER) $(SRCS) $(HDRS)
			
clean:
	rm $(TARGET) $(OBJS)

version:
	@echo $(VERSION)
	
## example for header only library
include:
	[[ -d src/include ]] || mkdir -p src/include
	wget https://raw.githubusercontent.com/badaix/popl/refs/heads/master/include/popl.hpp -o src/include/popl.hpp
