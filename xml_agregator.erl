-module(xml_agregator).
-export([process_xml/1]).
-include_lib("xmerl/include/xmerl.hrl").

fix_xml(Xml)->
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>" ++ string:substr(Xml, 49, length(Xml) - 48).

zip([H1|T1], [H2|T2], Acc)->
    zip(T1, T2, Acc ++ [{H1, H2}]);
zip([], [], Acc) ->
    Acc.
    
processDate([{_,_,_,_,_,_,_,_,D,_}|T], Acc)->
    processDate(T, Acc ++ [D]);
processDate([], Acc) ->
    Acc.

processValue([{_,_,_,_,V,_}|T], Acc)->
    processValue(T, Acc ++ [V]);
processValue([], Acc) ->
    Acc.

process_xml(Xml)->
    {R, _} = xmerl_scan:string(fix_xml(Xml)),
    zip(processDate(xmerl_xpath:string("//@Date", R), []), 
	processValue(xmerl_xpath:string("//Value/text()", R), []), []).
    
    





