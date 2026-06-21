-- 1. List all books with author names.
SELECT b.id, b.title, b.isbn, a.name AS author_name, b.category, b.status
FROM books b
JOIN authors a ON a.id = b.author_id
ORDER BY b.title;

-- 2. Search books by title, ISBN, or author.
SELECT b.id, b.title, b.isbn, a.name AS author_name, b.status
FROM books b
JOIN authors a ON a.id = b.author_id
WHERE b.title ILIKE '%clean%'
   OR b.isbn ILIKE '%clean%'
   OR a.name ILIKE '%clean%';

-- 3. Show available books only.
SELECT id, title, category
FROM books
WHERE status = 'Available'
ORDER BY title;

-- 4. Show active members.
SELECT id, full_name, email, joined_at
FROM members
WHERE status = 'Active'
ORDER BY full_name;

-- 5. Show active loans.
SELECT l.id, b.title, m.full_name, l.loaned_at, l.due_at
FROM loans l
JOIN books b ON b.id = l.book_id
JOIN members m ON m.id = l.member_id
WHERE l.returned_at IS NULL
ORDER BY l.due_at;

-- 6. Show overdue active loans.
SELECT l.id, b.title, m.full_name, l.due_at, CURRENT_DATE - l.due_at AS days_overdue
FROM loans l
JOIN books b ON b.id = l.book_id
JOIN members m ON m.id = l.member_id
WHERE l.returned_at IS NULL
  AND l.due_at < CURRENT_DATE
ORDER BY l.due_at;

-- 7. Count books by status.
SELECT status, COUNT(*) AS total
FROM books
GROUP BY status
ORDER BY status;

-- 8. Count active loans per member.
SELECT m.full_name, COUNT(l.id) AS active_loans
FROM members m
LEFT JOIN loans l ON l.member_id = m.id AND l.returned_at IS NULL
GROUP BY m.id, m.full_name
ORDER BY active_loans DESC, m.full_name;

-- 9. Borrow a book manually.
BEGIN;
INSERT INTO loans (book_id, member_id, due_at)
VALUES (1, 1, CURRENT_DATE + INTERVAL '14 days');
UPDATE books SET status = 'Borrowed', updated_at = CURRENT_TIMESTAMP WHERE id = 1;
COMMIT;

-- 10. Return a book manually.
BEGIN;
UPDATE loans
SET returned_at = CURRENT_DATE,
    fine_amount = GREATEST((CURRENT_DATE - due_at), 0) * 1.00
WHERE id = 1
  AND returned_at IS NULL;
UPDATE books
SET status = 'Available', updated_at = CURRENT_TIMESTAMP
WHERE id = (SELECT book_id FROM loans WHERE id = 1);
COMMIT;
