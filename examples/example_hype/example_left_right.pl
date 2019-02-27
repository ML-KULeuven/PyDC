:- use_module(library(planning)).
:- use_module(library(lists)).

% Options
:- set_options(default),
   set_query_propagation(true),
   set_inference(backward(lazy)).
:- set_current2nextcopy(false).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


get_position(X):t <- position:t ~= distribution(val(X)).
get_position(X):t <- position:t ~= X.

stop:t <- get_position(X):t, X>5.
reward:t ~ val(R) <- stop:t, R is 1000.
reward:t ~ val(R) <-  \+stop:t, R is -1.



movement(-1) <- true.
movement(1) <- true.
adm(action(move(X))):t <- movement(X).



position:0 ~ val(ObsX) <-
   observation(position_obs) ~= ObsX.
position:t+1 ~ val(ObsX) <-
   observation(position_obs) ~= ObsX.
position:t+1 ~ val(NX) <-
   action(move(DX)),
   get_position(X):t,
   NX is X+DX.
position:t+1 ~ val(OldX) <-
   get_position(OldX):t.

observation(position_obs):t+1 ~ val(_) <- true.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxV(D,V):t <- V is 1000.
init :- executedplan_start.
getparam(left_right) :-
	bb_put(user:spant,0),
	setparam(
        % enable abstraction
        false,
        % ratio of the samples reserved for the first action
        1.0,
        % use correct formula (leave true)
        true,
        % strategy to store V function
        max,
        % ExecAction
        best,
        % most,
        % Domain
        propfalse,
        % relfalse,
        % Discount
        0.95,
        % probability to explore in the beginning (first sample)
        0.0,
        % probability to explore in the end (last sample)
        0.0,
        % number of previous samples to use to estimate Q. Larger is better but slower
        100,
        % max horizon span
        200,
        % lambda init
        0.9,
        % lambda final
        0.9,
        % UCBV
        false,
        % decay
        0.015,
        % action selection: softmax | egreedy
        softmax,
        % egreedy,
        % Pruning
        0,
        % WHeuInit
        -0.1,
        % WHeuFinal
        -0.1),
!.
