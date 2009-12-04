-module(xml_agregator).
-export([process_xml/1]).
-include_lib("xmerl/include/xmerl.hrl").

fix_xml(Xml)->
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>" ++ string:substr(Xml, 49, length(Xml) - 48).

processDate([{_,_,_,_,_,_,_,_,D,_}|T])->
    io:format("~p~n", [D]),
    processDate(T);
processDate([]) ->
    io:format("end~n").

processValue([{_,_,_,_,V,_}|T])->
    io:format("~p~n", [V]),
    processValue(T);
processValue([]) ->
    io:format("end~n").


process_xml(Xml)->
    {R, _} = xmerl_scan:string(fix_xml(Xml)),
    processDate(xmerl_xpath:string("//@Date", R)),
    processValue(xmerl_xpath:string("//Value/text()", R)).
    
    





