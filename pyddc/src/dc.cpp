#include "dc.h"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string>

initerrordc exceptiondc;

dc::dc(string file, int n_samples): base(file, n_samples) {
   initialize_dc();
}
dc::dc(): base(){}

dc::~dc(){}


bool dc::initialize_dc(){
	YAP_Term error;
	char temp[100];
	sprintf(temp,"init");
	int res=YAP_RunGoalOnce(YAP_ReadBuffer(temp,&error));
	if(res!=1)
		throw exceptiondc;
	return 1;
}


// evaluate probability of a query: query([evidence],[],query,n,P,_,_)
double dc::query(string query, string evidence){
	YAP_Term error;
/*	YAP_Atom q=YAP_LookupAtom("query");
	cout<<YAP_AtomName(q);
*/
	string goal="query([" + evidence + "],[],"+query + "," + std::to_string(n) + ",ProbabilityQuery,_,_)";
	YAP_Term tmp = YAP_ReadBuffer(goal.c_str(),&error);
	double prob;
	if(!runGoalOnce(tmp,5,prob)) return -1;

	return prob;
}

double dc::query(string query, string evidence, int n_samples){
	YAP_Term error;
	string goal="query([" + evidence + "],[],"+query + "," + std::to_string(n_samples) + ",ProbabilityQuery,_,_)";
	YAP_Term tmp = YAP_ReadBuffer(goal.c_str(),&error);
	double prob;
	if(!runGoalOnce(tmp,5,prob)) return -1;

	return prob;
}
