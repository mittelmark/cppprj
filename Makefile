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
	
## examples for header only libraries

popl: src/include/popl.hpp
json: src/include/json.hpp
glob: src/include/glob.hpp
csv:  src/include/csv.hpp
ini:  src/include/SimpleIni.h
nanorange: src/include/nanorange.hpp
inja: src/include/inja.hpp
rang: src/include/rang.hpp
doctest: src/include/doctest.hpp
toml: src/include/toml.hpp
tree: src/include/tree.hpp
yaml: src/include/node.hpp

include:
	[[ -d src/include ]] || mkdir -p src/include

src/include/popl.hpp: include
	wget https://raw.githubusercontent.com/badaix/popl/refs/heads/master/include/popl.hpp -O src/include/popl.hpp
src/include/json.hpp: include
	wget https://github.com/nlohmann/json/releases/download/v3.12.0/json.hpp -O src/include/json.hpp
src/include/glob.hpp: include
	wget https://github.com/p-ranav/glob/blob/master/single_include/glob/glob.hpp -O src/include/glob.hpp
src/include/csv.hpp: include
	wget https://raw.githubusercontent.com/vincentlaucsb/csv-parser/refs/heads/master/single_include/csv.hpp -o src/include/csv.hpp
src/include/SimpleIni.h: include
	wget https://raw.githubusercontent.com/brofield/simpleini/refs/heads/master/SimpleIni.h -O src/include/SimpleIni.h
src/include/nanorange.hpp: include
	wget https://raw.githubusercontent.com/tcbrindle/NanoRange/master/single_include/nanorange.hpp -O src/include/nanorange.hpp
src/include/inja.hpp: include
	wget https://raw.githubusercontent.com/pantor/inja/refs/heads/main/single_include/inja/inja.hpp -O src/include/inja.hpp
src/include/rang.hpp: include
	wget https://github.com/agauniyal/rang/releases/download/v3.2/rang.hpp -o src/include/rang.hpp
src/include/doctest.hpp: include
	wget https://github.com/doctest/doctest/releases/download/v2.4.12/doctest.h -O src/include/doctest.hpp
src/include/toml.hpp: include
	wget https://raw.githubusercontent.com/ToruNiina/toml11/refs/heads/main/single_include/toml.hpp -O src/include/toml.hpp
src/include/tree.hpp: include
	wget https://raw.githubusercontent.com/kpeeters/tree.hh/master/src/tree.hh -O src/include/tree.hpp
src/include/node.hpp: include
	wget https://raw.githubusercontent.com/fktn-k/fkYAML/refs/heads/develop/single_include/fkYAML/node.hpp -O src/include/node.hpp
other:	
	## example for pipe interface
	wget "https://raw.githubusercontent.com/ziotom78/gplotpp/refs/heads/master/gplot%2B%2B.h" -o src/include/gplot++.hpp
	## maddy markdown converter
	## https://github.com/progsource/maddy
