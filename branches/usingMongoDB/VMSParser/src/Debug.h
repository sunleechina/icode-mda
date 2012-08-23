#ifndef Debug_h
#define Debug_h
#include <iostream>

#define _DEBUG

#ifdef _DEBUG
#define debug(x)  std::cerr << x  << std::endl;
#else
#define debug(x)
#endif

#endif