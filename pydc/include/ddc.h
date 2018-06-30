#include <iostream>
#include <exception>
#include <string>
#include <Yap/YapInterface.h>
#include <Yap/c_interface.h>
#include "base.h"
#include <vector>

using namespace std;

#ifndef DDC_H
#define DDC_H

class initerrorddc: public std::exception
{
	virtual const char* what() const throw()
	{
	return "Initialization error: file not found or particle initialization failed";
	}
};


class ddc: public base
{

	public:
      ddc();
		ddc(string file, int n_particles);
      ~ddc();

		bool initialize_particles();
		bool step(string actions,string observations,double delta);
		double query(string q);
		double querylist(string id, string query, vector<string> &ids, vector<double> &probs);
};


#endif
