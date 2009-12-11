-module(manager).
-import(settings).
-import(web_crawler).
-import(ex_agregator).
-import(publisher).
-export([start/0]).

start()->
    ex_agregator:register_agregator(),
    process_url_list(settings:read()),
    publisher:to_xml(
      ex_agregator:get_result(agregator)
     ).

process_url_list([{Currency, Url}|H])->
    ex_agregator:process(agregator, Currency, web_crawler:download(Url)),
    process_url_list(H);
process_url_list([]) ->
    io:format("end~n").


