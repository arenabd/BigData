#include "Lexer.hh"

Lexer::Lexer(std::string fileName):
  _fileName(fileName),
  _correct(true)
{
}

Lexer::~Lexer()
{
}

std::string const &	Lexer::getFileName() const
{
  return this->_fileName;
}

void			Lexer::setFileName(std::string const & fileName)
{
  this->_fileName = fileName;
}

bool			Lexer::isValidFile() const
{
  int		size = this->_fileName.size();
  int		pos = this->_fileName.size() - 4;

  if (size >= 5)
    {
      std::string ext = ".csv";
      if (this->_fileName.substr(pos, 4) == ext)
	return true;
      else
	return false;
    }
  return false;
}
