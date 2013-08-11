CXX      = g++
CXXFLAGS = -Wall -O2 -fPIC
LDFLAGS  = -fPIC

PREFIX  = /usr/local
LIBDIR  = $(PREFIX)/lib

SOURCES = ast.cpp bind.cpp constants.cpp context.cpp contextualize.cpp \
	copy_c_str.cpp error_handling.cpp eval.cpp expand.cpp extend.cpp file.cpp \
	functions.cpp inspect.cpp output_compressed.cpp output_nested.cpp \
	parser.cpp prelexer.cpp sass.cpp sass_interface.cpp to_c.cpp to_string.cpp \
	units.cpp

OBJECTS = $(SOURCES:.cpp=.o)

all: static

static: libsass.a
shared: libsass.so

libsass.a: $(OBJECTS)
	ar rvs $@ $(OBJECTS)

libsass.so: $(OBJECTS)
	$(CXX) -shared $(LDFLAGS) -o $@ $(OBJECTS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%: %.o libsass.a
	$(CXX) $(CXXFLAGS) -o $@ $+ $(LDFLAGS)

install: libsass.a
	install -Dpm0755 $< $(DESTDIR)$(LIBDIR)/$<

install-shared: libsass.so
	install -Dpm0755 $< $(DESTDIR)$(LIBDIR)/$<

sassc:
	make -C $(SASS_SASSC_PATH)

test: sassc libsass.a 
	ruby $(SASS_SPEC_PATH)/sass-spec.rb -d=$(SASS_SPEC_PATH) -c=$(SASS_SASSC_PATH)/bin/sassc

test_issues: sassc libsass.a 
	ruby $(SASS_SPEC_PATH)/sass-spec.rb -d=$(SASS_SPEC_PATH)/spec/issues -c=$(TARGET)

clean:
	rm -f $(OBJECTS) *.a *.so sassc++


.PHONY: all static shared bin install install-shared clean

