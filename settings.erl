-module(settings).
-export([read/0]).
-import(string_split).

read()->
    {ok, Device} = file:open("links", [read]),
    [Currency, Start, Finish] = get_lines_from_file(Device, [], 0, 0),
    create_url_list(Currency, Start, Finish, []).

get_lines_from_file(Device, Currency, Start, Finish)->
    case io:get_line(Device, "") of
	eof->
	    file:close(Device),
	    [Currency, Start, Finish];
	Line->
	    [Parm, _, Value] = process_config_line(Line),
	    case (Parm) of
		"Code" ->
		    get_lines_from_file(Device, Currency ++ [Value], Start, Finish);
		"Start" ->
		    get_lines_from_file(Device, Currency, Value, Finish);
		"Finish" ->
		    get_lines_from_file(Device, Currency, Start, Value);
		_ ->
		    get_lines_from_file(Device, Currency, Start, Finish)
	    end
    end.
    
process_config_line(Line)->
    case Line of
	"\n"->
	    ["empty", 0, "empty"];
	_ ->
	    L1 = lists:subtract(Line, "\n"),
	    string_split:split(L1, "=+")
    end.

create_url_list([H|T], Start, Finish, Urls)->
    Url = "http://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=" ++ Start ++ "&date_req2=" ++ Finish ++ "&VAL_NM_RQ=" ++ H,
    create_url_list(T, Start, Finish, Urls ++ [{H, Url}]);
create_url_list([], Start, Finish, Urls) ->
    Urls.
