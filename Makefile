REBAR=		rebar
DIALYZER=	dialyzer


.PHONY: plt analyze all deps compile get-deps clean

all: get-deps compile

deps: get-deps compile

get-deps:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

test: eunit

eunit: compile clean-test-btrees
	@$(REBAR) eunit skip_deps=true

eunit_console:
	erl -pa .eunit deps/*/ebin

clean-test-btrees:
	rm -fr .eunit/Btree_* .eunit/simple

plt: compile
	$(DIALYZER) --build_plt --output_plt .hanoi.plt \
		-pa deps/snappy/ebin \
	-pa deps/snappy/ebin \
	-pa deps/lz4/ebin \
	-pa deps/ebloom/ebin \
		-pa deps/plain_fsm/ebin \
		deps/plain_fsm/ebin \
		--apps erts kernel stdlib ebloom lz4 snappy

analyze: compile
	$(DIALYZER) --plt .hanoi.plt \
	-pa deps/snappy/ebin \
	-pa deps/lz4/ebin \
	-pa deps/ebloom/ebin \
	-pa deps/plain_fsm/ebin \
	ebin

analyze-nospec: compile
	$(DIALYZER) --plt .hanoi.plt \
	-pa deps/plain_fsm/ebin \
        --no_spec \
	ebin

repl:
	erl -pz deps/*/ebin -pa ebin
