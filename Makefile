.PHONY: setup-homebrew

ifndef USER
$(error USER variable is not set)
endif

deps: 
	brew install ansible

setup-homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "\n# Homebrew environment setup" >> /Users/$(USER)/.zprofile
	@echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(USER)/.zprofile
	@eval "$$(/opt/homebrew/bin/brew shellenv)"
