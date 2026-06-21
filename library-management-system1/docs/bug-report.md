# Bug Report

## Bug Report Template

| Field | Details |
| --- | --- |
| Bug ID | BUG-001 |
| Title | Short and clear defect title |
| Module | Schema / Authors / Books / Members / Loans / Reports |
| Severity | Critical / High / Medium / Low |
| Priority | High / Medium / Low |
| Environment | PostgreSQL database, local QA environment |
| Preconditions | Database setup, seed data, specific record IDs |
| Steps to Reproduce | Numbered steps with SQL commands or query names |
| Expected Result | What should happen according to requirements |
| Actual Result | What actually happened |
| Test Data | Input values used during testing |
| Evidence | Screenshot, query output, or error message |
| Status | New / Open / Fixed / Retest / Closed |
| Reported By | QA tester name |
| Reported Date | Date reported |

## Sample Bug Reports

### BUG-001: System Allows Suspended Member Loan Through Direct SQL

| Field | Details |
| --- | --- |
| Module | Loans |
| Severity | High |
| Priority | High |
| Preconditions | A member exists with status `Suspended`; a book exists with status `Available` |
| Steps to Reproduce | Insert a loan record using the suspended member ID and available book ID |
| Expected Result | Loan should not be allowed for suspended members |
| Actual Result | Database accepts the loan because this rule is not enforced by a database constraint |
| Status | Open |
| Notes | This is expected to be handled in future service logic or with a database trigger |

### BUG-002: Active Loan Limit Not Enforced By Database Constraint

| Field | Details |
| --- | --- |
| Module | Loans |
| Severity | High |
| Priority | Medium |
| Preconditions | One active member already has 3 active loans |
| Steps to Reproduce | Insert a 4th active loan for the same member |
| Expected Result | Member should not be allowed to borrow more than 3 active books |
| Actual Result | Database accepts the 4th loan unless service logic blocks it |
| Status | Open |
| Notes | This rule should be validated in the backend/API phase |
