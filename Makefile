.PHONY: init
init:
	docker run --rm -it --user "`id -u`":"`id -g`" -v `pwd`:/esdoc -w /esdoc node:lts-slim /bin/bash -c "npm i"

.PHONY: clean
clean:
	@rm -rf node_modules out

.PHONY: bash
bash:
	docker run --rm -it --net host --user "`id -u`":"`id -g`" -v `pwd`:/src -w /src node:lts-slim /bin/bash -c "npm run; /bin/bash -i"

#.PHONY: publish
#publish: clean init
#	docker run --rm -it --net host --user "`id -u`":"`id -g`" -v `pwd`:/src -w /src node:lts-slim /bin/bash -c "npm login; npm run build; npm publish --access public"
