-module(serializator).
-export([to_file/2]).

to_file(Data, Filename)->
    file:write_file(Filename, Data).

    
