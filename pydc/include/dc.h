#include <iostream>
#include <exception>
#include <string>
#include <Yap/YapInterface.h>
#include <Yap/c_interface.h>
#include "base.h"

#ifndef DC_H
#define DC_H


class initerrordc: public std::exception
{
	virtual const char* what() const throw()
	{
	return "Initialization error: file not found or particle initialization failed";
	}
};

class dc : public base {
   private:
      bool initialize_dc();
   

	public:
      dc();
		dc(string file, int n);
		~dc();

		double query(string query,string evidence);
		double query(string query,string evidence, int n_samples);
};


#endif
