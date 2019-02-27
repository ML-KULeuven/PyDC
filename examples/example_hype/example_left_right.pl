:- use_module(library(planning)).
:- use_module(library(lists)).

% Options
:- set_options(default),
   set_query_propagation(true),
   set_inference(backward(lazy)).
:- set_current2nextcopy(false).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


get_position(X):t <- pos:t ~= distribution(val(X)).
get_position(X):t <- pos:t ~= X.

stop:t <-
   \+action(move(_)),
   get_position(X):t, X>5, writeln(X).
reward:t ~ val(1000) <- stop:t.
reward:t ~ val(-1) <- \+stop:t.


adm(action(move(left))):t <- true.
adm(action(move(right))):t <- true.



pos:t+1 ~ val(ObsX) <-
   observation(pos):t ~= ObsX.

pos:t+1 ~ val(NX) <-
   action(move(left)),
   get_position(X):t,
   NX is X-1.
pos:t+1 ~ val(NX) <-
   writeln(1),
   action(move(right)),
   writeln(2),
   get_position(X):t,
   NP is X+1.

pos:t+1 ~ val(OldX) <-
   get_position(OldX):t.


observation(pos):t+1 ~ val(_).



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
