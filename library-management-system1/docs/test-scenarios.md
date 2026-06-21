# Test Scenarios

| Scenario ID | Module | Scenario | Related Test Cases |
| --- | --- | --- | --- |
| TS-001 | Schema | Verify all database objects are created correctly | TC-001, TC-002 |
| TS-002 | Authors | Validate author creation and duplicate prevention | TC-003, TC-006, TC-007 |
| TS-003 | Books | Validate book creation with required fields and valid author | TC-008, TC-009 |
| TS-004 | Books | Validate book constraints for ISBN, year, and status | TC-004, TC-010, TC-011 |
| TS-005 | Books | Validate book availability queries | TC-012 |
| TS-006 | Members | Validate member creation and required contact data | TC-005, TC-013, TC-014 |
| TS-007 | Members | Validate member status rules | TC-015, TC-016 |
| TS-008 | Loans | Validate loan creation for available books | TC-017 |
| TS-009 | Loans | Validate one active loan per book | TC-018 |
| TS-010 | Loans | Validate loan and return date constraints | TC-019, TC-020 |
| TS-011 | Loans | Validate book return and fine calculation | TC-021, TC-022, TC-023 |
| TS-012 | Loans | Validate active and overdue loan queries | TC-024, TC-025 |
| TS-013 | Business Rules | Review rules that need future service-layer validation | TC-026, TC-027 |
| TS-014 | Reports | Validate summary and grouping queries | TC-028, TC-029 |
| TS-015 | Data Quality | Validate relational data integrity | TC-030 |

## High-Level User Flow

1. Librarian adds authors.
2. Librarian adds books linked to authors.
3. Librarian registers members.
4. Active member borrows an available book.
5. Book status changes to `Borrowed`.
6. Member returns the book.
7. Fine is calculated if the return is overdue.
8. Book status changes back to `Available`.
9. Librarian reviews active loans, overdue loans, and book status reports.
