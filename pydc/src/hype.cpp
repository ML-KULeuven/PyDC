#include "hype.h"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>
#include <typeinfo>


initerrorhype exceptionhype;


inline const string bool_to_string(bool b) {
	return b ? string("true") : string("false");
}


hype::hype(){}
hype::hype(string model_file, int n_samples): ddc(model_file, n_samples){
   initialize_plan();
}
hype::~hype(){}


bool hype::initialize_plan(){
	YAP_Term error;
	char temp[100];
	sprintf(temp,"executedplan_start");
	int res=YAP_RunGoalOnce(YAP_ReadBuffer(temp,&error));
	if(res!=1)
		throw exceptionhype;
	return 1;
}

bool hype::plan_step(
                     string observations,
                     bool use_abstraction,
                     uint32_t nb_samples,
                     uint32_t max_horizon,
                     uint32_t used_horizon,
                     string &best_action,
                     float &total_reward,
                     uint32_t &time,
                     bool &stop
                  ) {

	YAP_Term error;
	string goal = "executedplan_step(BestAction, "
		+ bool_to_string(use_abstraction) + ", "
		+ observations + ", "
		+ std::to_string(nb_samples) + ", "
		+ std::to_string(max_horizon)
		+ ", TotalReward, "
		+ "Time, "
		+ std::to_string(used_horizon)
		+ ", Stop)";

	std::cout << goal << std::endl;
	YAP_Term tmp = YAP_ReadBuffer(goal.c_str(), &error);
	long safe_t = YAP_InitSlot(tmp); // have a safe pointer to term
	int res = YAP_RunGoalOnce(tmp);

	if (res == -1) {
		return -1;
	}

	YAP_Int best_action_slot = YAP_NewSlots(1);
	YAP_Int total_reward_slot = YAP_NewSlots(1);
	YAP_Int time_slot = YAP_NewSlots(1);
	YAP_Int stop_slot = YAP_NewSlots(1);

	YAP_PutInSlot(best_action_slot, YAP_ArgOfTerm(1, YAP_GetFromSlot(safe_t)));
	YAP_PutInSlot(total_reward_slot, YAP_ArgOfTerm(6, YAP_GetFromSlot(safe_t)));
	YAP_PutInSlot(time_slot, YAP_ArgOfTerm(7, YAP_GetFromSlot(safe_t)));
	YAP_PutInSlot(stop_slot, YAP_ArgOfTerm(9, YAP_GetFromSlot(safe_t)));

	if (!YAP_IsIntTerm(YAP_GetFromSlot(stop_slot)) || !YAP_IsIntTerm(YAP_GetFromSlot(time_slot)) || !YAP_IsFloatTerm(YAP_GetFromSlot(total_reward_slot))) {
		return -1;
	}

	stop = YAP_IntOfTerm(YAP_GetFromSlot(stop_slot));
	time = YAP_IntOfTerm(YAP_GetFromSlot(time_slot));
	total_reward = YAP_FloatOfTerm(YAP_GetFromSlot(total_reward_slot));

	char buff[10000];
	YAP_WriteBuffer(YAP_GetFromSlot(best_action_slot), buff, 10000, YAP_WRITE_HANDLE_VARS);

	best_action = string(buff);

   YAP_RecoverSlots(4);

	return 1;
}
