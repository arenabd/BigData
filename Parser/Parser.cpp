#include "Parser.hh"

Parser::Parser(std::string fileName):
  _fileName(fileName)
{
  this->_lexer = new Lexer(fileName);
}

Parser::~Parser()
{
  delete this->_lexer;
}

void		Parser::init()
{
  if (this->_lexer->isValidFile() == true)
    this->launchParsing();
  else
    std::cout << "le fichier " << this->_fileName << " n'est pas valide." << std::endl;;
}

void		Parser::launchParsing()
{
  std::string line;
  std::string validStrFile = "./validFiles/";
  std::ifstream	file(this->_fileName.c_str());
  validStrFile += this->_fileName;
  std::ofstream validFile(validStrFile.c_str());

  if (file.is_open() && validFile.is_open())
    {
      while (getline(file, line))
	{
	  if (!line.empty())
	    {
	      validFile << this->checkLine(line).c_str();
	      validFile << "\n";
	    }
	}
      file.close();
      validFile.close();
    }
  else
    std::cout << "Erreur : impossible d'ouvrir le fichier" << std::endl;
}

std::string		Parser::checkLine(std::string	& line)
{
  std::string	newLine;
  if (!line.empty())
    {
      for (int i = 0; i < line.length(); ++i)
	{
	  if (line[i] == ',')
	    {
	      if (i != 0 && i != line.length() - 1 && line[i + 1] != ',')
		newLine += ",";
	    }
	  else if (line[i] < 27 || line[i] > 126)
	    {
	      newLine += 'e';
	    }
	  else
	    newLine += line[i];
	}
    }
  return newLine;
}
