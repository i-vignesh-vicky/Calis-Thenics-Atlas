# Calis-Thenics-Atlas

Calis-Thenics Atlas is an ambitious product and engineering planning repository for an intelligent fitness platform that helps users train consistently, improve over time, and stay motivated through personalized guidance.

## Overview

This repository is the working home for the product vision, domain model, engineering decisions, and execution backlog for the Calis-Thenics Atlas MVP. It is designed to help a solo builder or small team move from product thinking to implementation with a clear, practical plan.

## What this repo contains

- High-level working entrypoints in [CLAUDE.md](CLAUDE.md), [ARCHITECTURE.md](ARCHITECTURE.md), [PRODUCT.md](PRODUCT.md), and [CONVENTIONS.md](CONVENTIONS.md)
- Product strategy and requirements in [docs/01-product](docs/01-product)
- Domain model, business rules, and event definitions in [docs/02-domain](docs/02-domain)
- Architecture, engineering standards, and technical guidance in [docs/03-engineering](docs/03-engineering)
- Archived strategy context (foundation, AI, business, founder notes) in [docs/archive](docs/archive)
- Weekly implementation backlog files in [docs/stories](docs/stories)
- The central execution roadmap in [docs/stories/PLAN.md](docs/stories/PLAN.md)

## Primary goals

- Define the MVP clearly and narrowly
- Turn product requirements into actionable engineering work
- Break delivery into weekly slices that can be implemented incrementally
- Keep the repository useful as both a planning artifact and an execution guide

## Recommended reading order

1. Start with [docs/stories/PLAN.md](docs/stories/PLAN.md) for the execution strategy.
2. Review [docs/01-product/product-roadmap.md](docs/01-product/product-roadmap.md) and [docs/01-product/functional-requirements.md](docs/01-product/functional-requirements.md) for the product scope.
3. Use [docs/03-engineering/architecture.md](docs/03-engineering/architecture.md) and [docs/03-engineering/backend.md](docs/03-engineering/backend.md) for technical direction.
4. Follow the weekly files in [docs/stories](docs/stories) for implementation backlog and delivery steps.

## Repository structure

```text
.
├── README.md
├── docs/
│   ├── 01-product/
│   ├── 02-domain/
│   ├── 03-engineering/
│   ├── archive/
│   └── stories/
```

## MVP delivery focus

The current execution plan centers on shipping a practical MVP with:

- identity and access
- user profile and onboarding
- exercise library
- routines and programs
- workout execution and logging
- progress and milestones
- notifications, search, and settings

## Status

This repository is currently focused on planning, documentation, and implementation backlog creation rather than application code. The weekly story files provide the next layer of execution detail for turning the product vision into working software.

## Contributing

When updating this repository:

- keep the documentation clear and implementation-oriented
- prefer concise, actionable language over abstract strategy prose
- ensure weekly backlog files remain practical enough to execute
- preserve the distinction between product requirements, engineering decisions, and delivery tasks
