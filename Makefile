ERLC = erlc

all: manager.beam settings.beam web_crawler.beam xml_agregator.beam

manager.beam : manager.erl
	$(ERLC) manager.erl

settings.beam : settings.erl
	$(ERLC) settings.erl

web_crawler.beam : web_crawler.erl
	$(ERLC) web_crawler.erl

xml_agregator.beam : xml_agregator.erl
	$(ERLC) xml_agregator.erl

clean: 
	-rm *.beam