:- use_module(library(dcpf)).
:- set_options(default).
:- set_inference(backward(lazy)).


%facts
city(brussels) <- true.

%initial state
weather(C):0 ~ finite([0.6:rainy,0.4:sunny]) <- city(C).


%state model
temperature(C):t ~ gaussian(10,6) <- weather(C):t ~= rainy.
temperature(C):t ~ gaussian(24,8) <- weather(C):t ~= sunny.

%transition model
weather(C):t+1 ~ finite([0.7:rainy,0.3:sunny]) <- weather(C):t ~= rainy.
weather(C):t+1 ~ finite([0.4:rainy,0.6:sunny]) <- weather(C):t ~= sunny.

activity(tintin):t+1 ~finite([0.1:walk,0.4:shop,0.5:clean]) <-
   weather(brussels):t+1 ~= rainy.
activity(tintin):t+1 ~ finite([0.6:walk,0.3:shop,0.1:clean]) <-
   weather(brussels):t+1 ~= sunny.

%observation model add uncertainty if you want
observation(activity(tintin)):t+1 ~ val(_).
