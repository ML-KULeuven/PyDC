#include <iostream>
#include <exception>
#include <string>
#include <Yap/YapInterface.h>
#include <Yap/c_interface.h>
#include "ddc.h"
#include <vector>

using namespace std;

#ifndef HYPE_H
#define HYPE_H

class initerrorhype: public std::exception
{
	virtual const char* what() const throw()
	{
	return "Initialization error: file not found or particle initialization failed";
	}
};


class hype: public ddc
{

	public:
      hype();
		hype(string file, int n_particles);
      ~hype();


		// bool plan_step(string observations, bool use_abstraction, uint32_t nb_samples, uint32_t max_horizon, uint32_t used_horizon, string &best_action, float &total_reward, uint32_t &time, bool &stop);

};
#endif
