###############################################################################
#
# 	Tomorec - Makefile
#
#    This Makefile is used for building the jupyterlab docker
#    images locally using docker.
#
#  	Run 'make' for usage information
#
###############################################################################

# Makefile stuff
.DEFAULT_GOAL := help
SHELL := /bin/bash
.ONESHELL:
THIS_FILE := $(lastword $(MAKEFILE_LIST))

# Colors
LIGHTPURPLE := \033[1;35m
GREEN := \033[32m
CYAN := \033[36m
BLUE := \033[34m
RED := \033[31m
NC := \033[0m

# Separator between output, 80 characters wide
define print_separator
	printf "$1"; printf "%0.s*" {1..80}; printf "$(NC)\n"
endef
print_line_green = $(call print_separator,$(GREEN))
print_line_blue = $(call print_separator,$(BLUE))
print_line_red = $(call print_separator,$(RED))


###############################################################################
##@ Help
###############################################################################

.PHONY: help

help:  ## Display this help message
	@printf "\n"
	$(print_line_blue)
	printf "$(BLUE)Jupyter Docker Stacks $(CYAN)Makefile$(NC)\n"
	printf "    This Makefile is used for building the jupyterlab docker\n"
	printf "    images locally using docker.\n"
	printf "    Images that are to be used for deployment are created \n"
	printf "    in the CI pipeline. See .gitlab-ci.yml\n"
	$(print_line_blue)
	printf "\n"
	$(print_line_blue)
	printf "$(BLUE)Usage\n    $(CYAN)make $(NC)<target>\n"
	printf "\n$(BLUE)Examples$(NC)\n"
	printf "    $(CYAN)make $(NC)build-base-notebook$(NC)\n"
	printf "    $(CYAN)make $(NC)build-tomorec-notebook$(NC)\n"
	printf "    $(CYAN)make $(NC)run-tomorec-image$(NC)\n"
	awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-].*##/ \
	{ printf "    $(CYAN)%-23s$(NC) %s\n", $$1, $$2} /^##@/ \
	{ printf "\n$(BLUE)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	$(print_line_blue)


###############################################################################
##@ Build Images - For local use, with docker
###############################################################################

.PHONY: build-base-notebook build-tomorec-notebook 

build-base-notebook: ## Use docker to build tomorec image 
	@printf "\n"
	$(print_line_blue)

	docker build \
		--build-arg NB_USER=$$USER \
 		--build-arg NB_UID=$$(id -u) \
 		--build-arg NB_GID=$$(id -g) \
		-t base-notebook:local \
		-f docker/base-notebook/Dockerfile .
	
	$(print_line_blue)
	printf "\n"


build-tomorec-notebook: ## Use docker to build tomorec image 
	@printf "\n"
	$(print_line_blue)

	docker build \
		--build-arg NB_USER=$$USER \
 		--build-arg NB_UID=$$(id -u) \
 		--build-arg NB_GID=$$(id -g) \
		-t tomorec:local \
		-f docker/tomorec-notebook/Dockerfile .
	
	$(print_line_blue)
	printf "\n"


###############################################################################
##@ Run Images - For local use, with docker
###############################################################################

.PHONY: run-tomorec-image 

run-tomorec-image: ## Start a docker container using tomorec image
	@printf "\n"
	$(print_line_blue)

	docker run -it --rm -p 8888:8888 \
		-v "$${PWD}":/home/$$USER/work \
		--user $(id -u):$(id -g) \
		--env MEM_LIMIT=7516192768 \
		tomorec:local

	$(print_line_blue)
	printf "\n"
