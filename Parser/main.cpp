#include <cstdlib>
#include "Parser.hh"

int		main(int ac, char **av)
{

  if (ac == 2)
    {
      Parser parser(av[1]);

      parser.init();
    }
  else
    std::cout << "USAGE : ./parsecsv + file.csv" << std::endl;
  return EXIT_SUCCESS;
}
