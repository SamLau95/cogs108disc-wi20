.PHONY: help copy

LAST_DISC = $(lastword $(sort $(wildcard disc*)))

OFFICIAL_REPO = /Users/sam/repos/cogs108/Section_Wi20/sam

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

copy: ## Copies section files into the official sections folder
	rsync -avh . ${OFFICIAL_REPO} --delete --exclude='.git/'

push: copy ## Pushes both this repo and official repo to GitHub
	git add -A
	git commit -m "${LAST_DISC}"
	git push
	cd ${OFFICIAL_REPO} && \
	  git add -A && git commit -m "sam ${LAST_DISC}" && git push
