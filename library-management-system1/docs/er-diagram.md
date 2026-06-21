# ER Diagram

Image version: [er-diagram-relationship-summary.svg](er-diagram-relationship-summary.svg)

```mermaid
erDiagram
  AUTHORS ||--o{ BOOKS : writes
  MEMBERS ||--o{ LOANS : borrows
  BOOKS ||--o{ LOANS : loaned_as

  AUTHORS {
    int id PK
    varchar name UK
    text bio
    timestamp created_at
  }

  BOOKS {
    int id PK
    varchar isbn UK
    varchar title
    int author_id FK
    varchar category
    int published_year
    varchar status
    timestamp created_at
    timestamp updated_at
  }

  MEMBERS {
    int id PK
    varchar full_name
    varchar email UK
    varchar phone
    varchar status
    date joined_at
    timestamp updated_at
  }

  LOANS {
    int id PK
    int book_id FK
    int member_id FK
    date loaned_at
    date due_at
    date returned_at
    decimal fine_amount
  }
```

## Relationship Summary

| Relationship | Type | Description |
| --- | --- | --- |
| Authors to Books | One-to-many | One author can write many books. Each book has one author. |
| Members to Loans | One-to-many | One member can have many historical loans. Each loan belongs to one member. |
| Books to Loans | One-to-many | One book can appear in many historical loans. Only one active loan per book is allowed. |

## Cardinality Rules

- A book cannot exist without an author.
- A loan cannot exist without a valid book and valid member.
- A book can have many past loans, but only one loan where `returned_at IS NULL`.
- A member can borrow up to 3 active books.
