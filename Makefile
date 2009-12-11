ERLC = erlc

all: manager.beam settings.beam web_crawler.beam xml_agregator.beam ex_agregator.beam string_split.beam publisher.beam

manager.beam : manager.erl
	$(ERLC) manager.erl

settings.beam : settings.erl
	$(ERLC) settings.erl

web_crawler.beam : web_crawler.erl
	$(ERLC) web_crawler.erl

xml_agregator.beam : xml_agregator.erl
	$(ERLC) xml_agregator.erl

ex_agregator.beam: ex_agregator.erl
	$(ERLC) ex_agregator.erl

string_split.beam: string_split.erl
	$(ERLC) string_split.erl

publisher.beam: publisher.erl
	$(ERLC) publisher.erl

clean: 
	-rm *.beam