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
	    get_lines_from_file(Device, Accum ++ [process_url(Line)])
    end.

process_url(Url)->
    lists:subtract(Url, "\n").
