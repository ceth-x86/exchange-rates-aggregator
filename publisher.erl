-module(publisher).
-export([to_xml/1]).

to_xml(Dict)->
    xml_header() ++ "<Rates>" ++ to_xml_currency(dict:to_list(Dict), []) ++ "</Rates>".

xml_header()->
    "<?xml version='1.0'?>".

to_xml_currency([H|T], Acc)->
    {Currency, [Rates]} = H,    
    to_xml_currency(T, Acc ++ "<Currency Name=" ++ Currency ++ ">" ++ to_xml_rates(Rates, []) ++ "</Currency>");
to_xml_currency([], Acc) ->
    Acc.

to_xml_rates([H|T], Acc)->
    {Date, Value} = H,
    to_xml_rates(T, Acc ++ "<Rate Date=" ++ Date ++ ">" ++ Value ++ "</Rate>");
to_xml_rates([], Acc) ->
    Acc.
    
