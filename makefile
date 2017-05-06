#!/usr/bin/make -f
NAME=jamesbrink/mariadb
TEMPLATE=Dockerfile.template
SETUP_SCRIPT=setup_mariadb_repo.sh
ENTRY_SCRIPT=entrypoint.sh

.PHONY: all 10.1 10.0
.DEFAULT_GOAL := latest

all: 10.1 10.0

10.1:
	mkdir -p $(@)
	printf "`cat $(TEMPLATE)`" $(@) $(@) $(@) > $(@)/Dockerfile
	cp $(SETUP_SCRIPT) $(@)
	cp $(ENTRY_SCRIPT) $(@)
	# docker tag 
	docker build -t $(NAME):$(@) $(@)

10.0:
	mkdir -p $(@)
	printf "`cat $(TEMPLATE)`" $(@) $(@) $(@) > $(@)/Dockerfile
	cp $(SETUP_SCRIPT) $(@)
	cp $(ENTRY_SCRIPT) $(@)
	docker build -t $(NAME):$(@) $(@)
