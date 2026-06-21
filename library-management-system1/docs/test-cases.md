# QA Test Cases

These test cases are designed for database-level manual testing using PostgreSQL. Reset the database by running `sql/schema.sql` and `sql/seed.sql` before a full regression pass.

| ID | Module | Test Scenario | Test Steps | Test Data | Expected Result | Priority |
| --- | --- | --- | --- | --- | --- | --- |
| TC-001 | Schema | Verify all required tables exist | Query `information_schema.tables` | `authors`, `books`, `members`, `loans` | All four tables exist | High |
| TC-002 | Schema | Verify primary keys exist | Check table constraints | All tables | Each table has a primary key on `id` | High |
| TC-003 | Schema | Verify author name uniqueness | Insert two authors with same `name` | `Robert Martin` | Second insert is rejected | High |
| TC-004 | Schema | Verify book ISBN uniqueness | Insert two books with same `isbn` | Existing ISBN | Second insert is rejected | High |
| TC-005 | Schema | Verify member email uniqueness | Insert two members with same `email` | Existing email | Second insert is rejected | High |
| TC-006 | Authors | Add valid author | Insert author with valid `name` and `bio` | `J. K. Rowling` | Author is saved successfully | Medium |
| TC-007 | Authors | Reject author without name | Insert author with null `name` | `NULL` | Insert is rejected by NOT NULL constraint | High |
| TC-008 | Books | Add valid book | Insert book with valid ISBN, title, author, category, year | Valid author ID | Book is saved with status `Available` | High |
| TC-009 | Books | Reject book without author | Insert book with invalid `author_id` | `99999` | Insert is rejected by foreign key constraint | High |
| TC-010 | Books | Reject future published year | Insert book with future year | Current year + 1 | Insert is rejected by check constraint | Medium |
| TC-011 | Books | Reject invalid book status | Insert or update status to invalid value | `Archived` | Change is rejected by check constraint | High |
| TC-012 | Books | Verify available book query | Run available-books query | `status = 'Available'` | Only available books are returned | Medium |
| TC-013 | Members | Add valid active member | Insert member with name, email, phone | `qa.user@example.com` | Member is saved with status `Active` | High |
| TC-014 | Members | Reject member without email | Insert member with null email | `NULL` | Insert is rejected by NOT NULL constraint | High |
| TC-015 | Members | Reject invalid member status | Insert or update status to invalid value | `Blocked` | Change is rejected by check constraint | High |
| TC-016 | Members | Verify active member query | Run active-members query | `status = 'Active'` | Only active members are returned | Medium |
| TC-017 | Loans | Create loan for available book | Insert loan for available book and active member, then update book status | Valid `book_id`, `member_id` | Loan is created and book status becomes `Borrowed` | High |
| TC-018 | Loans | Reject duplicate active loan for same book | Insert active loan for a book that already has an active loan | Same `book_id`, `returned_at IS NULL` | Insert is rejected by unique active-loan index | High |
| TC-019 | Loans | Verify due date rule | Insert loan with `due_at` before `loaned_at` | `due_at < loaned_at` | Insert is rejected by check constraint | High |
| TC-020 | Loans | Verify returned date rule | Update loan with `returned_at` before `loaned_at` | `returned_at < loaned_at` | Update is rejected by check constraint | High |
| TC-021 | Loans | Return active loan | Update loan with `returned_at = CURRENT_DATE` and set book to `Available` | Active loan ID | Loan is returned and book is available | High |
| TC-022 | Loans | Calculate no fine for on-time return | Return loan on or before due date | Current date <= due date | Fine amount remains `0.00` | Medium |
| TC-023 | Loans | Calculate overdue fine | Return loan after due date | 5 days late | Fine amount equals `5.00` | High |
| TC-024 | Loans | Verify active loans query | Run active-loans query | `returned_at IS NULL` | Only active loans are returned | Medium |
| TC-025 | Loans | Verify overdue loans query | Run overdue-loans query | Due date before current date | Only overdue active loans are returned | High |
| TC-026 | Business Rule | Validate member active loan limit | Count active loans for one member before new loan | 3 active loans | Tester identifies that a 4th loan must be blocked by future business logic | High |
| TC-027 | Business Rule | Validate suspended member cannot borrow | Check member status before loan insert | `Suspended` member | Tester identifies loan should not be allowed by future service logic | High |
| TC-028 | Reports | Count books by status | Run status count query | Seed data | Totals are grouped correctly by status | Low |
| TC-029 | Reports | Count active loans per member | Run active-loans-per-member query | Seed data | Active loan count is correct for each member | Medium |
| TC-030 | Data Quality | Verify no orphan books | Left join books to authors | Seed data | No book has missing author reference | High |

## Regression Priority

- Smoke: TC-001, TC-002, TC-008, TC-013, TC-017, TC-021
- Core regression: TC-001 through TC-025
- Business rule review: TC-026, TC-027
- Reporting and data quality: TC-028 through TC-030
