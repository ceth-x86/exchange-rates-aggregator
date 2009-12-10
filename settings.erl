-module(settings).
-export([read/0]).

read()->
    {ok, Device} = file:open("links", [read]),
    get_lines_from_file(Device, []).

get_lines_from_file(Device, Accum)->
    case io:get_line(Device, "") of
	eof->
	    file:close(Device),
	    Accum;
	Line->
	    Url = process_config_line(Line),
	    case (Url) of
		"empty" ->
		    get_lines_from_file(Device, Accum);
		_ ->
		    get_lines_from_file(Device, Accum ++ [Url])	       
	    end
    end.

% < -- regexp split 
regexp_loop(Str, Parts, Index, []) ->
    lists:reverse([string:substr(Str, Index)] ++ Parts);
regexp_loop(Str, Parts, Index, Rem_Matches) ->
    {NextPt,PtLen} = hd(Rem_Matches),
    regexp_loop( Str, [ string:substr(Str, NextPt, PtLen),
                        string:substr(Str, Index, NextPt - Index)]
                      ++ Parts, NextPt + PtLen,
                      tl(Rem_Matches) ).
regexp_split_inclusive(Str, Regex) ->
    {match, Matches} = re:matches(Str, Regex),
    regexp_loop(Str, [], 1, Matches).
% -->
    
process_config_line(Line)->
    L1 = lists:subtract(Line, "\n"),
    create_url(regexp_split_inclusive(L1, "=+")).

create_url([[]])->
    "empty";
create_url([_, _, Value])->
    "http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=01/12/2009&date_req2=06/12/2009&VAL_NM_RQ=" ++ Value.
    
