:- use_module(library(distributionalclause)).
:- use_module(library(lists)).
:- set_options(default), set_inference(backward(lw)).

nballs ~ uniform([1,2,3,4,5,6,7,8,9,10]) <- true.

ball(X) <- nballs ~= N, between(1,N,X).


drawn(Draw) ~ uniform(Balls) <- nballs ~= N, findall(X,between(1,N,X),Balls).

g ~ gaussian(0,0.01) <- true.
g2 ~ gaussian(X,0.01) <- g ~=X.
