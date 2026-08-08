# STORY-056 · Add Release Configuration Checks

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Verify that release-critical configuration is correct before the beta build is cut.

## Implementation Steps

- [ ] Audit environment variables and configuration values required for production against the current staging config.
- [ ] Add a configuration validation script or startup check that fails loudly if required values are missing.
- [ ] Document the full list of required configuration keys and their expected formats.

## Technical Notes

- The validation check should run at startup so a misconfigured environment surfaces immediately.
- Do not log secret values; log only the key names and whether they are present.

## Tests

- [ ] Add a test for the configuration validation script covering present and missing values.

## Documentation

- [ ] Document the required configuration keys and the validation script.

## Acceptance Criteria

- [ ] The validation script identifies missing required config.
- [ ] Startup fails loudly if config is incomplete.
- [ ] Config keys are documented.

## Deliverables

- Configuration validation script
- Required config key documentation
- Startup integration
