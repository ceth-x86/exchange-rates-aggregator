-module(manager).
-import(settings).
-import(web_crawler).
-export([start/0]).

start()->
    process_url_list(settings:read()).

process_url_list([T|H])->
    web_crawler:download_xml(T),
    process_url_list(H);
process_url_list([]) ->
    io:format("end~n").
