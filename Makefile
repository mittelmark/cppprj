CC        := g++
SRC_DIR   := src
BUILD_DIR := build
SRCS      := $(wildcard $(SRC_DIR)/*.cpp)
HDRS      := $(wildcard $(SRC_DIR)/*.hpp)
OBJS      := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))
CFLAGS    := -O3 -Wall
LFLAGS    :=  # -lfmt -lncurses
FORMATTER := astyle --indent=spaces=4 --mode=c 
LINTER    := cppcheck

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

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CC) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $@	

lint:
	$(LINTER) $(SRCS) $(HDRS)

format:
	$(FORMATTER) $(SRCS) $(HDRS)
			
clean:
	rm $(TARGET) $(OBJS)
