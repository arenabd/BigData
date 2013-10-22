NAME=parsecsv
GCC=g++
RM=rm
CFLAGS= -c -Wall -Wmultichar
LDFLAGS=
SRCS= 	main.cpp \
	Parser.cpp \
	Lexer.cpp


OBJS=$(SCRCS:.cpp=.o)

all: $(NAME)

$(NAME): $(OBJS)
	$(GCC) $(LDFLAGS) $(SRCS) -o $(NAME)

.cpp.o:
	$(GCC) $(CFLAGS) $< -o $@

clean:
	$(RM) -f *.o *~ $(NAME)