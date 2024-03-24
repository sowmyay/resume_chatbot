dockerimage ?= resume-chatbot
dockerfile ?= Dockerfile
srcdir ?= $(shell pwd)
datadir ?= $(shell pwd)

install:
	@docker build -t $(dockerimage) -f $(dockerfile) .

i: install


update:
	@docker build -t $(dockerimage) -f $(dockerfile) . --pull --no-cache

u: update

jupyter:
	@docker run --ipc=host -it --rm -p 8888:8888 -p 8889:8889 --env-file ./.env -v $(srcdir):/home/app -v $(datadir):/data --entrypoint=/home/app/jupyter.sh $(dockerimage)

j: jupyter

publish:
	@docker image save $(dockerimage) 	  | pv -N "Publish $(dockerimage) to $(sshopts)" -s $(shell docker image inspect $(dockerimage) --format "{{.Size}}") 	  | ssh $(sshopts) "docker image load"

p: publish

.PHONY: install i update u publish p jupyter j

