# Database Schema

The system uses PostgreSQL and four core entities: `authors`, `books`, `members`, and `loans`.

## authors

| Column | Type | Constraint | Notes |
| --- | --- | --- | --- |
| id | SERIAL | Primary key | Unique author identifier |
| name | VARCHAR(120) | Required, unique | Author display name |
| bio | TEXT | Optional | Short author notes |
| created_at | TIMESTAMP | Required | Defaults to current timestamp |

## books

| Column | Type | Constraint | Notes |
| --- | --- | --- | --- |
| id | SERIAL | Primary key | Unique book identifier |
| isbn | VARCHAR(20) | Required, unique | ISBN value |
| title | VARCHAR(180) | Required | Book title |
| author_id | INTEGER | Required, foreign key | References `authors.id` |
| category | VARCHAR(80) | Required | Book category or genre |
| published_year | INTEGER | Optional, checked | Must be 1000 through current year |
| status | VARCHAR(20) | Required, checked | `Available`, `Borrowed`, `Lost`, `Maintenance` |
| created_at | TIMESTAMP | Required | Defaults to current timestamp |
| updated_at | TIMESTAMP | Required | Updated when book data changes |

## members

| Column | Type | Constraint | Notes |
| --- | --- | --- | --- |
| id | SERIAL | Primary key | Unique member identifier |
| full_name | VARCHAR(120) | Required | Member name |
| email | VARCHAR(160) | Required, unique | Should be stored in lowercase |
| phone | VARCHAR(30) | Optional | Contact number |
| status | VARCHAR(20) | Required, checked | `Active`, `Suspended`, `Inactive` |
| joined_at | DATE | Required | Defaults to current date |
| updated_at | TIMESTAMP | Required | Updated when member data changes |

## loans

| Column | Type | Constraint | Notes |
| --- | --- | --- | --- |
| id | SERIAL | Primary key | Unique loan identifier |
| book_id | INTEGER | Required, foreign key | References `books.id` |
| member_id | INTEGER | Required, foreign key | References `members.id` |
| loaned_at | DATE | Required | Defaults to current date |
| due_at | DATE | Required, checked | Must be on or after loan date |
| returned_at | DATE | Optional, checked | Must be null or on or after loan date |
| fine_amount | NUMERIC(10,2) | Required, checked | Must be zero or positive |

## Indexes

- `ux_one_active_loan_per_book`: prevents multiple active loans for the same book.
- `ix_books_author_id`: improves author/book joins.
- `ix_books_status`: improves filtering by book availability.
- `ix_loans_member_id`: improves member loan lookups.
- `ix_loans_due_at`: improves overdue loan reporting.
