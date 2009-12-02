-module(manager).
-import(settings).
-export([start/0]).

start()->
    process_url_list(settings:read()).

process_url_list([T|H])->
    io:format("url: ~p~n", [T]),
    process_url_list(H);
process_url_list([]) ->
    io:format("end~n").
