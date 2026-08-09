.PHONY: install build test db-up lint

# Windows: `make` requires Chocolatey (choco install make), Git Bash, or WSL.

install:
	@if [ -f backend/Atlas.sln ]; then \
		dotnet restore backend/; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		flutter pub get --directory frontend; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi

build:
	@if [ -f backend/Atlas.sln ]; then \
		dotnet build backend/ --no-restore --configuration Release; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		cd frontend && flutter build apk --debug; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi

test:
	@if [ -f backend/Atlas.sln ]; then \
		dotnet test backend/ --no-build; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		cd frontend && flutter test; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi

db-up:
	@echo "docker-compose.yml not yet added (see STORY-005C). Run: docker compose up -d"

lint:
	@if [ -f backend/Atlas.sln ]; then \
		dotnet format backend/ --verify-no-changes; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		cd frontend && dart analyze && dart format --set-exit-if-changed .; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi
