-module(web_crawler).
-import(xml_agregator).
-export([download/1]).

download(Url)->
    ibrowse:start(),
    io:format("~p~n", [Url]),
    {ok, _StatusCode, _Headers, WebPageText} = ibrowse:send_req(Url, [], get),
    Result = xml_agregator:process_xml(WebPageText),
    io:format("~p~n", [Result]).


