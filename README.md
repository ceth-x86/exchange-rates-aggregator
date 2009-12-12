# Description

This is Erlang script which reads config file:

    Start=01/12/2009
    Finish=06/12/2009
    Code=R01235
    Code=R01239

and generate xml:

    <?xml version='1.0'?>
      <Rates>
        <Currency Name=R01235>
          <Rate Date=01.12.2009>29,0687</Rate>
          <Rate Date=02.12.2009>29,1771</Rate>
          ...
        </Currency>
        <Currency Name=R01239>
          ...
        </Currency>
      </Rates>

# Installation

     $ make
     $ chmod 777 start.erl
     $ ./start.erl

# Author

Andrey Demidov :: andrey.demidov@gmail.com :: @ademidov


