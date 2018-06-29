#include "base.h"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string>

initerrorbasedc exceptionbasedc;

base::base(string file, int n_samples) {
	if(load(file)!=1)
		throw exceptionbasedc;
	YAP_Term error;
	emptylist=YAP_ReadBuffer("[]",&error);
	yap_false=YAP_ReadBuffer("false",&error);
	yap_true=YAP_ReadBuffer("true",&error);
   n = n_samples;
}

base::base() {}

base::~base() {}

bool base::load(string file){
	if (YAP_FastInit(NULL) == YAP_BOOT_ERROR)
		return false; //throw exceptiondc;
	else
		yaploaded=true;
	exec("yap_flag(informational_messages,off)");
	string goal="consult('"+file+"')";
	return exec(goal); // 1 ok
}





// execute an arbitrary prolog goal (query)
bool base::exec(string q){

	YAP_Term error;
	int res = YAP_RunGoalOnce(YAP_ReadBuffer(q.c_str(),&error));

	return res;
}

bool base::runGoalOnce(YAP_Term tmp,int argOutput, int &out){

	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);
	if (res==false)
		return false;
	out = YAP_IntOfTerm(YAP_ArgOfTerm(argOutput,YAP_GetFromSlot(safe_t)));
	YAP_RecoverSlots(1); // safe copy not needed anymore

	return true;
}


bool base::runGoalOnce(YAP_Term tmp,int argOutput, double &out){

	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);
	if (res==false)
		return false;
	out = YAP_FloatOfTerm(YAP_ArgOfTerm(argOutput,YAP_GetFromSlot(safe_t)));
	YAP_RecoverSlots(1); // safe copy not needed anymore
	return true;
}


YAP_Term base::runGoalOnce(YAP_Term tmp,int argOutput){

	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);
	if (res==false)
		return 0;
	YAP_Term out = YAP_FloatOfTerm(YAP_ArgOfTerm(argOutput,YAP_GetFromSlot(safe_t)));
	YAP_RecoverSlots(1); // safe copy not needed anymore
	return out;
}
