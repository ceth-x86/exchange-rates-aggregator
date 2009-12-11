-module(manager).
-import(settings).
-import(web_crawler).
-import(ex_agregator).
-export([start/0]).

start()->
    ex_agregator:register_agregator(),
    process_url_list(settings:read()),
    Result = ex_agregator:get_result(agregator),
    io:format("~p~n", [Result]).

process_url_list([{Currency, Url}|H])->
    ex_agregator:process(agregator, Currency, web_crawler:download(Url)),
    process_url_list(H);
process_url_list([]) ->
    io:format("end~n").


