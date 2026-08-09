.PHONY: install build test smoke db-up db-migrate db-reset lint

# Windows: `make` requires Chocolatey (choco install make), Git Bash, or WSL.

install:
	@if [ -f backend/Atlas.slnx ]; then \
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
	@if [ -f backend/Atlas.slnx ]; then \
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
	@if [ -f backend/Atlas.slnx ]; then \
		dotnet test backend/ --no-build; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		cd frontend && flutter test; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi

smoke:
	@echo "--- Backend smoke test ---"
	@dotnet test backend/ --filter "FullyQualifiedName~HealthEndpointTests" --verbosity normal
	@echo "--- Frontend smoke test ---"
	@cd frontend && flutter test test/app_smoke_test.dart

db-up:
	@docker compose up -d postgres

db-migrate:
	@cd backend && dotnet ef database update --project src/Atlas.Infrastructure --startup-project src/Atlas.Api

db-reset:
	@docker compose down -v && docker compose up -d postgres && sleep 2 && cd backend && dotnet ef database update --project src/Atlas.Infrastructure --startup-project src/Atlas.Api

lint:
	@if [ -f backend/Atlas.slnx ]; then \
		dotnet format backend/ --verify-no-changes; \
	else \
		echo "Backend not yet initialized — see STORY-003"; \
	fi
	@if [ -f frontend/pubspec.yaml ]; then \
		cd frontend && dart analyze && dart format --set-exit-if-changed .; \
	else \
		echo "Frontend not yet initialized — see STORY-004"; \
	fi
