CSVAWK = ./csvawk

all: lint test

lint:
	pep8 $(CSVAWK)

TEST_SUM = test.csv | md5sum | cut -d' ' -f1
TEST_DE = -d '~' -e '*' --output-delimiter ';' --output-enclosure '|'

test:
	# Check proper output
	test $$($(CSVAWK) '{print $$1}' $(TEST_SUM)) = 7237e59ae0c066932928eee93442f47b
	test $$($(CSVAWK) '{print $$2}' $(TEST_SUM)) = 1b59de16fe446473716767c2aec1f6a3
	test $$($(CSVAWK) '{print $$3}' $(TEST_SUM)) = 73e2e94a6e514c0da121c6f0394c0e3f

	# Check delimiter and enclosure
	test "$$(echo '*a~b*~c;d' | $(CSVAWK) $(TEST_DE) '{print}' | sed 's/\r$$//')" = 'a~b;|c;d|'
