:- use_module(library(planning)).
:- use_module(library(lists)).

% Options
:- set_options(default),
   set_query_propagation(true),
   set_inference(backward(lazy)).

:- set_current2nextcopy(false).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_pos(X):t <- pos:t ~= distribution(val(X)).
get_pos(X):t <- pos:t ~= X.

reward:t ~ val(R) <- stop:t, R is 1000.0.
reward:t ~ val(R) <-  \+stop:t, R is -1.0.
stop:t <- get_pos(X):t, X>4.

adm(action(move(A,B))):t <-
   member((A,B),[(1.0,0.0),(-1.0,0.0)]).

pos:t+1 ~ val(X) <-
   \+pos:t ~= _,
   observation(pos) ~= X.
pos:t+1 ~ val(X) <-
   observation(pos) ~= X.
pos:t+1 ~ val(NX) <-
   action(move(DX,DY)),
   pos:t ~= X,
   NX is X+DX.
pos:t+1 ~ val(X) <-
   pos:t ~= X.

observation(pos):t+1 ~ val(_) <-
   pos:t+1 ~= _.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxV(D,100):t <- true.

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
