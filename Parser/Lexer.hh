#ifndef		_LEXER_HH_
#define		_LEXER_HH_

#include <string>
#include <iostream>

class	Lexer
{
private:  
  Lexer();
  std::string	_fileName;
  bool		_correct;

public:
  Lexer(std::string);
  ~Lexer();

  std::string const &   getFileName() const;
  void			setFileName(std::string const &);
  bool			isValidFile() const;
};

#endif
