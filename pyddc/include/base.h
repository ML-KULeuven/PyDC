#include <iostream>
#include <exception>
#include <string>
#include <Yap/YapInterface.h>
#include <Yap/c_interface.h>
#include <stdio.h>


using namespace std;

#ifndef BASE_H
#define BASE_H

class initerrorbasedc: public std::exception
{
	virtual const char* what() const throw()
	{
	return "Initialization error: file not found or particle initialization failed";
	}
};



class base {
   private:
		bool yaploaded=false;
		bool load(string file);

	protected:
		YAP_Term emptylist,yap_false,yap_true;

   public:
      base();
      base(string file, int n);
      ~base();

		bool	runGoalOnce(YAP_Term tmp,int argOutput, int &out);
		bool	runGoalOnce(YAP_Term tmp,int argOutput, double &out);
      YAP_Term runGoalOnce(YAP_Term tmp,int argOutput);

      bool exec(string q);

      int n;

};

#endif
