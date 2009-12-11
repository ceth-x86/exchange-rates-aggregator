-module(string_split).
-export([split/2]).

regexp_loop(Str, Parts, Index, []) ->
    lists:reverse([string:substr(Str, Index)] ++ Parts);

regexp_loop(Str, Parts, Index, Rem_Matches) ->
    {NextPt,PtLen} = hd(Rem_Matches),
    regexp_loop( Str, [ string:substr(Str, NextPt, PtLen),
                        string:substr(Str, Index, NextPt - Index)]
                      ++ Parts, NextPt + PtLen,
                      tl(Rem_Matches) ).
split(Str, Regex) ->
    {match, Matches} = regexp:matches(Str, Regex),
    regexp_loop(Str, [], 1, Matches).
