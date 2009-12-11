-module(ex_agregator).
-export([register_agregator/0, process/3]).

register_agregator()->
    register(agregator, start_agregator()).

start_agregator()->
    spawn(fun prepare_agregator/0).

prepare_agregator()->
    loop_agregator(dict:new()).

loop_agregator(Dict)->
    receive
	{From, {process, {Currency, Data}}}->
	    io:format("currency: ~p~n", [Currency]),
	    io:format("here: ~p~n", [Data]),
	    From ! {self(), "print"},
	    loop_agregator(dict:append(Currency, Data, Dict));
	{From, Other}->
	    io:format("Invalid input in agregator ~p~n", [Other]),
	    From ! {self(), {error,Other}},
	    loop_agregator(Dict)
    end.

agregator_rpc(Pid, Data)->
    Pid ! {self(), Data},
    receive
	{NewPid, Responce}->
	    Responce
    end.

process(Pid, Currency, Data)->
    agregator_rpc(Pid, {process, {Currency, Data}}).

    
