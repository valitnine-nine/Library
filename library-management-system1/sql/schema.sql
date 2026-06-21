DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  bio TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  phone VARCHAR(30),
  status VARCHAR(20) NOT NULL DEFAULT 'Active',
  joined_at DATE NOT NULL DEFAULT CURRENT_DATE,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_member_status CHECK (status IN ('Active', 'Suspended', 'Inactive'))
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  isbn VARCHAR(20) NOT NULL UNIQUE,
  title VARCHAR(180) NOT NULL,
  author_id INTEGER NOT NULL REFERENCES authors(id),
  category VARCHAR(80) NOT NULL,
  published_year INTEGER,
  status VARCHAR(20) NOT NULL DEFAULT 'Available',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_book_status CHECK (status IN ('Available', 'Borrowed', 'Lost', 'Maintenance')),
  CONSTRAINT chk_published_year CHECK (
    published_year IS NULL OR (published_year >= 1000 AND published_year <= EXTRACT(YEAR FROM CURRENT_DATE))
  )
);

CREATE TABLE loans (
  id SERIAL PRIMARY KEY,
  book_id INTEGER NOT NULL REFERENCES books(id),
  member_id INTEGER NOT NULL REFERENCES members(id),
  loaned_at DATE NOT NULL DEFAULT CURRENT_DATE,
  due_at DATE NOT NULL,
  returned_at DATE,
  fine_amount NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
  CONSTRAINT chk_due_after_loan CHECK (due_at >= loaned_at),
  CONSTRAINT chk_return_after_loan CHECK (returned_at IS NULL OR returned_at >= loaned_at),
  CONSTRAINT chk_fine_amount CHECK (fine_amount >= 0)
);

CREATE UNIQUE INDEX ux_one_active_loan_per_book
ON loans(book_id)
WHERE returned_at IS NULL;

CREATE INDEX ix_books_author_id ON books(author_id);
CREATE INDEX ix_books_status ON books(status);
CREATE INDEX ix_loans_member_id ON loans(member_id);
CREATE INDEX ix_loans_due_at ON loans(due_at);
