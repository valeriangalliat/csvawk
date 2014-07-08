CSVAWK = ./csvawk
TEST = test.csv | md5sum | cut -d' ' -f1

all: lint test

lint:
	pep8 $(CSVAWK)

test:
	test $$($(CSVAWK) '{print $$1}' $(TEST)) = 7237e59ae0c066932928eee93442f47b
	test $$($(CSVAWK) '{print $$2}' $(TEST)) = 1b59de16fe446473716767c2aec1f6a3
	test $$($(CSVAWK) '{print $$3}' $(TEST)) = 73e2e94a6e514c0da121c6f0394c0e3f
