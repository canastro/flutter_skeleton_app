SHELL = /usr/bin/sh
.PHONY: clean localizations analyze install format test launch

help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

all: ## Runs full analysis on the project.
all: format analyze test

localizations: ## Generate localizations for app.
	@echo "╠ Generating localizations..."
	@sh ./scripts/localizations.sh app

install: ## Install the whole project.
	@echo "╠ Installing the project..."
	@sh ./scripts/install.sh packages
	@sh ./scripts/install.sh app

analyze: ## Analyze the whole project.
	@echo "╠ Analyzing the project..."
	@sh ./scripts/analyze.sh packages
	@sh ./scripts/analyze.sh app

test: ## Test the whole project.
	@echo "╠ Testing the project..."
	@sh ./scripts/test.sh packages
	@sh ./scripts/test.sh app

format: ## Format the whole project.
	@echo "╠ Formatting the code"
	@flutter format .

clean: ## Cleaning the whole project.
	@echo "╠ Cleaning the project..."
	@sh ./scripts/clean.sh packages
	@sh ./scripts/clean.sh app

launch: ## Run the app.
	@echo "╠ Running the project..."
	@cd app; flutter run -t lib/main_qa.dart
