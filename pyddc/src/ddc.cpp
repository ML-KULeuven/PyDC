#include "ddc.h"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>
#include <typeinfo>


initerrorddc exceptionddc;

ddc::ddc(){}
ddc::ddc(string file, int n_particles): base(file, n_particles){
   initialize_particles();
}
ddc::~ddc(){}


bool ddc::initialize_particles(){
	YAP_Term error;
	char temp[100];
	sprintf(temp,"init_particle(%d)", n);
	int res=YAP_RunGoalOnce(YAP_ReadBuffer(temp,&error));
	if(res!=1)
		throw exceptionddc;
	return 1;
}





bool ddc::step(string actions,string observations,double delta=1.0){
	string stepstring="step_particle([" + actions + "],[" + observations + "]," + std::to_string(n) + "," + std::to_string(delta) +")";
	YAP_Term error;
	char command[10000];
	strcpy(command,stepstring.c_str());
	int res = YAP_RunGoalOnce(YAP_ReadBuffer(command,&error));
	return res;
}



double ddc::query(string query){
	YAP_Term error;
	string goal="eval_query_particle(" + query + "," + std::to_string(n) + ",ProbabilityQuery)";
	YAP_Term tmp = YAP_ReadBuffer(goal.c_str(),&error);
	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);
	if (res==false)
		return -1;
	double prob=YAP_FloatOfTerm( YAP_ArgOfTerm(3,YAP_GetFromSlot(safe_t)) );
	YAP_RecoverSlots(1); // safe copy not needed anymore

	return prob;
}

double ddc::querylist(string id,string query,vector<string> &ids,vector<double> &probs){

	YAP_Term error;
	string goal="eval_query_particle2("+id+"," + query + "," + std::to_string(n) + ",ProbabilityQuery)";
	YAP_Term tmp = YAP_ReadBuffer(goal.c_str(),&error);
	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);
	if (res==false)
		return -1;

	int dimension=0;
	YAP_Term head, list = YAP_ArgOfTerm(4,YAP_GetFromSlot(safe_t));
	while(YAP_IsPairTerm(list))
	{
		head = YAP_HeadOfTerm(list);
		YAP_Term p=YAP_ArgOfTerm(1,head);
		char buff[10000];
		YAP_WriteBuffer(YAP_ArgOfTerm(2,head),buff,100,0);
		ids.push_back(string(buff));
		double prob;
		if(YAP_IsIntTerm(p))
				prob = YAP_IntOfTerm(p);
			else if(YAP_IsFloatTerm(p))
				prob = YAP_FloatOfTerm(p);
			else
				return false;
		probs.push_back(prob);

		list = YAP_TailOfTerm(list);
		dimension++;
	}
	if(dimension==0)
		return false;
	YAP_RecoverSlots(1); // safe copy not needed anymore
	return 0;
}
