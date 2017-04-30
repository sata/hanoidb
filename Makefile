.PHONY: compile deps clean test dialyzer clean-test-btrees

REBAR = ./rebar3
DIALYZER= dialyzer

compile:
	$(REBAR) compile

deps:
	$(REBAR) do upgrade, tree

clean:
	$(REBAR) clean

test: clean-test-btrees
	$(REBAR) eunit skip_deps=true

clean-test-btrees:
	rm -fr .eunit/Btree_* .eunit/simple

dialyzer:
	$(REBAR) dialyzer

