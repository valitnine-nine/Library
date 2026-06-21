# Business Logic

## Book Management

- ISBN must be unique.
- Title, author, category, and ISBN are required when creating a book.
- Published year is optional, but if present must be between 1000 and the current year.
- Book status must be one of `Available`, `Borrowed`, `Lost`, or `Maintenance`.
- A book can be borrowed only when its status is `Available`.

## Member Management

- Member email must be unique.
- Member email is normalized to lowercase before saving.
- Member status must be one of `Active`, `Suspended`, or `Inactive`.
- Only members with `Active` status can borrow books.

## Loan Management

- A loan requires an existing book and member.
- A member can have at most 3 active loans.
- A book can have only one active loan at a time.
- A new loan sets `due_at` to 14 days after the loan date.
- Creating a loan changes book status to `Borrowed`.
- Returning a loan sets `returned_at` to the current date.
- Returning a loan changes book status back to `Available`.
- Returning an overdue book calculates a fine at `1.00` per overdue day.
- A returned loan cannot be returned again.

## Database Validation Rules

| Scenario | Expected Database Behavior |
| --- | --- |
| Missing required field | Insert or update is rejected by NOT NULL constraint |
| Invalid book/member status | Insert or update is rejected by CHECK constraint |
| Duplicate ISBN, author name, or member email | Insert or update is rejected by UNIQUE constraint |
| Invalid author, book, or member reference | Insert or update is rejected by FOREIGN KEY constraint |
| Same book has two active loans | Insert is rejected by partial unique index |
| Due date before loan date | Insert or update is rejected by CHECK constraint |
| Return date before loan date | Insert or update is rejected by CHECK constraint |
| Negative fine amount | Insert or update is rejected by CHECK constraint |

## Future Service Logic

These rules are documented for the next backend/API phase. They should be tested manually through SQL review now and automated later when service logic exists.

- Check member status before creating a loan.
- Check active loan count before creating a loan.
- Check book availability before creating a loan.
- Automatically set due date to 14 days after loan date.
- Automatically update book status after borrow and return operations.
- Automatically calculate overdue fines during return.
