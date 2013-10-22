#ifndef		__PARSER_HH__
#define		__PARSER_HH__

#include <fstream>
#include <string>
#include <iostream>
#include "Lexer.hh"

class		Parser
{
private:
  Parser();

  int		_id;
  std::string	_fileName;
  Lexer	*	_lexer;

  void		launchParsing();
  std::string 	checkLine(std::string &);

public:
  Parser(std::string);
  ~Parser();

public:
  void		init();

};

#endif
