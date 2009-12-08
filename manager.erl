-module(manager).
-import(settings).
-import(web_crawler).
-import(ex_agregator).
-export([start/0]).

start()->
    ex_agregator:register_agregator(),
    process_url_list(settings:read()).

process_url_list([T|H])->
    ex_agregator:process(agregator, web_crawler:download(T)),
    process_url_list(H);
process_url_list([]) ->
    io:format("end~n").
