EXECUTABLES = convolution_color hw4writeup
#CC=gcc49

all: $(EXECUTABLES) 

LDFLAGS += $(foreach librarydir,$(subst :, ,$(LD_LIBRARY_PATH)),-L$(librarydir))

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
  LDFLAGS += -lrt -lOpenCL -lm
  CFLAGS += -std=gnu99 -g -O2
endif
ifeq ($(UNAME_S),Darwin)
  LDFLAGS +=  -framework OpenCL -lm
  CFLAGS += -std=c99 -g -O2
endif

ifdef OPENCL_INC
  CPPFLAGS = -I$(OPENCL_INC)
endif

ifdef OPENCL_LIB
  LDFLAGS = -L$(OPENCL_LIB)
endif

convolution_color.o: convolution_color.c cl-helper.h timing.h
cl-helper.o: cl-helper.c cl-helper.h
ppma_io.o: ppma_io.c ppma_io.h

convolution_color: convolution_color.o ppma_io.o cl-helper.o
hw4writeup: hw4writeup.tex
	pdflatex hw4writeup.tex


clean:
	rm -f $(EXECUTABLES) *.o *.aux *.dvi *.pdf *.log *.out *.gz
