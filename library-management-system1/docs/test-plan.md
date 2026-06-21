# Test Plan

## Objective

Validate the Library Management System database design, SQL schema, relationship rules, business logic assumptions, and reporting queries before frontend or API development begins.

## Scope

In scope:

- Database tables and columns
- Primary keys, foreign keys, unique constraints, and check constraints
- ER diagram relationships
- SQL schema execution
- Seed data loading
- Query correctness
- Database-level business rules
- QA documentation completeness

Out of scope:

- Frontend testing
- API testing
- Authentication testing
- Performance testing at production scale
- Payment or notification testing

## Test Items

- `sql/schema.sql`
- `sql/seed.sql`
- `sql/queries.sql`
- `docs/schema.md`
- `docs/er-diagram.md`
- `docs/business-logic.md`
- `docs/test-cases.md`

## Test Approach

- Execute schema script in a clean PostgreSQL database.
- Load seed data and verify that all records are inserted successfully.
- Run positive tests for valid authors, books, members, and loans.
- Run negative tests for required fields, invalid statuses, duplicate values, invalid dates, and invalid foreign keys.
- Run reporting queries and compare results with seed data.
- Log defects using the bug report template.

## Entry Criteria

- PostgreSQL is installed and accessible.
- QA database is created.
- Schema and seed SQL files are available.
- Business rules are reviewed.

## Exit Criteria

- All high-priority schema and relationship tests pass.
- All failed tests are logged as bugs.
- Known limitations are documented.
- Test summary report is completed.

## Risks

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Some business rules require application logic | Database may pass invalid workflow actions | Document as future backend/API validation |
| Seed data may not cover all edge cases | Defects may be missed | Add targeted test data during QA execution |
| Manual SQL testing can be inconsistent | Results may vary by tester | Use clear test cases and record actual query output |

## Roles

| Role | Responsibility |
| --- | --- |
| Intern QA Tester | Execute test cases, record results, create bug reports |
| Mentor / Reviewer | Review defects, clarify requirements, approve summary report |
| Developer | Fix confirmed database or future service logic issues |
