PYTHON      := python3
ENV_ROOT    := $(shell pwd)/.env
ENV_BIN     := $(ENV_ROOT)/bin
PIP         := $(ENV_BIN)/pip
ISORT       := $(ENV_BIN)/isort
BLACK       := $(ENV_BIN)/black
FLAKE8      := $(ENV_BIN)/flake8
PYTEST      := $(ENV_BIN)/pytest

.PHONY: clean
clean:
	@rm -rf $(ENV_ROOT)

.PHONY: pre-setup-venv
pre-setup-venv: clean
	@$(PYTHON) -m venv $(ENV_ROOT)
	@$(PIP) install --upgrade pip

.PHONY: setup-venv
setup-venv: pre-setup-venv
	@$(PIP) install -r requirements.txt

.PHONY: install-root-packages
install-root-packages:
	@$(PIP) install isort black flake8 pytest

.PHONY: save-requirements
save-requirements:
	@$(PIP) freeze > requirements.txt

.PHONY: format
format:
	@echo "Running isort"
	@$(ISORT) *.py
	@echo "Running black"
	@$(BLACK) *.py

.PHONY: check-format
check-format:
	@echo "Running isort"
	@$(ISORT) --check *.py
	@echo "Running black"
	@$(BLACK) --check *.py

.PHONY: lint
lint:
	@echo "Running flake8"
	@$(FLAKE8) *.py

.PHONY: test
test:
	@echo "Running pytest"
	@$(PYTEST) -v
