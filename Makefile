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
	
## examples for useful header only libraries

popl: include
	@[[ -f src/include/popl.hpp ]] || \
	wget https://raw.githubusercontent.com/badaix/popl/refs/heads/master/include/popl.hpp -O src/include/popl.hpp

json: include
	@[[ -f src/include/json.hpp ]] || \
	wget https://github.com/nlohmann/json/releases/download/v3.12.0/json.hpp -O src/include/json.hpp
	
glob: include
	[[ -f src/include/glob.hpp ]] || \
	wget https://github.com/p-ranav/glob/blob/master/single_include/glob/glob.hpp -O src/include/glob.hpp

csv:  include
	@[[ -f src/include/csv.hpp ]] || \
	wget https://raw.githubusercontent.com/vincentlaucsb/csv-parser/refs/heads/master/single_include/csv.hpp -O src/include/csv.hpp	
ini:  include
	@[[ -f src/include/SimpleIni.h ]] || \
	wget https://raw.githubusercontent.com/brofield/simpleini/refs/heads/master/SimpleIni.h -O src/include/SimpleIni.h	

nanorange: include
	@[[ -f src/include/nanorange.hpp ]] || \
	wget https://raw.githubusercontent.com/tcbrindle/NanoRange/master/single_include/nanorange.hpp -O src/include/nanorange.hpp	

inja: include
	@[[ -f src/include/inja.hpp ]] || \
	wget https://raw.githubusercontent.com/pantor/inja/refs/heads/main/single_include/inja/inja.hpp -O src/include/inja.hpp	

rang: include
	@[[ -f src/include/rang.hpp ]] || \
	wget https://github.com/agauniyal/rang/releases/download/v3.2/rang.hpp -O src/include/rang.hpp	

doctest: include
	@[[ -f src/include/doctest.hpp ]] || \
	wget https://github.com/doctest/doctest/releases/download/v2.4.12/doctest.h -O src/include/doctest.hpp	

toml: include
	@[[ -f src/include/toml.hpp ]] || \
	wget https://raw.githubusercontent.com/ToruNiina/toml11/refs/heads/main/single_include/toml.hpp -O src/include/toml.hpp
	
tree: include
	@[[ -f src/include/tree.hpp ]] || \
	wget https://raw.githubusercontent.com/kpeeters/tree.hh/master/src/tree.hh -O src/include/tree.hpp	

yaml: include
	@[[ -f src/include/node.hpp ]] || \
	wget https://raw.githubusercontent.com/fktn-k/fkYAML/refs/heads/develop/single_include/fkYAML/node.hpp -O src/include/node.hpp

include:
	@[[ -d src/include ]] || mkdir -p src/include

other:	
	## example for pipe interface
	wget "https://raw.githubusercontent.com/ziotom78/gplotpp/refs/heads/master/gplot%2B%2B.h" -O src/include/gplot++.hpp
	## maddy markdown converter
	## https://github.com/progsource/maddy
