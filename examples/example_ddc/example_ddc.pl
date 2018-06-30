%this is a modified hipster version of the Friends & Smokers problem

:- use_module(library(dcpf)).
:- use_module(library(lists)).
:- set_options(default).
:- set_inference(backward(lazy)).


person(1) <- true.
person(2) <- true.
person(3) <- true.
person(4) <- true.

friend(1,2) <- true.
friend(2,1) <- true.
friend(2,4) <- true.
friend(3,2) <- true.
friend(4,2) <- true.

%initialization model
mindful(X):0 ~ finite([0.3:true,0.7:false]) <- person(X).
influences(X,Y):0 ~ finite([0.2:true,0.8:false]) <- person(X), person(Y).

vegan(X):0 ~ val(V) <- mindful(X):0 ~= V.
vegan(X):0 ~ val(V) <- friend(X,Y), influences(Y,X):0 ~= V, mindful(Y):0 ~= V.

%dependency model
annoying(X):t ~ finite([0.2:true,0.8:false]) <- vegan(X):t ~= true.
annoying(X):t ~ finite([0.1:true,0.9:false]) <- vegan(X):t ~= false.


%transtition model
mindful(X):t+1 ~ finite([0.99:true,0.01:false]) <- mindful(X):t ~= true.
mindful(X):t+1 ~ finite([0.01:true,0.99:false]) <- mindful(X):t ~= false.

influences(X):t+1 ~ val(false). %once a millenial has set their opinions they are not influenced by anybody anymore.

vegan(X):t+1 ~ finite([0.8:true,0.2:false]) <- vegan(X):t ~= true, mindful(X):t ~= false.

vegan(X):t+1 ~ finite([0.1:true,0.9:false]) <- vegan(X):t ~= false, mindful(X):t ~= true.
vegan(X):t+1 ~ val(V) <- vegan(X):t ~= V.
