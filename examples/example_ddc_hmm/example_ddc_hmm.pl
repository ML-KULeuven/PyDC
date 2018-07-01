:- use_module(library(dcpf)).
:- set_options(default).
:- set_inference(backward(lazy)).

%initial state
weather:0 ~ finite([0.6:rainy,0.4:sunny]).

%transition model
weather:t+1 ~ finite([0.7:rainy,0.3:sunny]) <- weather:t ~= rainy.
weather:t+1 ~ finite([0.4:rainy,0.6:sunny]) <- weather:t ~= sunny.

activity:t+1 ~ finite([0.1:walk,0.4:shop,0.5:clean]) <- weather:t+1 ~= rainy.
activity:t+1 ~ finite([0.6:walk,0.3:shop,0.1:clean]) <- weather:t+1 ~= sunny.

%observation model add uncertainty if you want
observation(activity):t+1 ~ val(_).
