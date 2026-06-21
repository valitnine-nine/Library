INSERT INTO authors (name, bio) VALUES
  ('George Orwell', 'British novelist and essayist.'),
  ('Jane Austen', 'English novelist known for social commentary.'),
  ('Robert C. Martin', 'Software engineering author.'),
  ('Chinua Achebe', 'Nigerian novelist and critic.'),
  ('Ursula K. Le Guin', 'American speculative fiction author.');

INSERT INTO books (isbn, title, author_id, category, published_year, status) VALUES
  ('9780451524935', '1984', 1, 'Fiction', 1949, 'Available'),
  ('9780141439518', 'Pride and Prejudice', 2, 'Classic', 1813, 'Available'),
  ('9780132350884', 'Clean Code', 3, 'Technology', 2008, 'Available'),
  ('9780385474542', 'Things Fall Apart', 4, 'Fiction', 1958, 'Available'),
  ('9780441478125', 'The Left Hand of Darkness', 5, 'Science Fiction', 1969, 'Maintenance'),
  ('9780452284234', 'Animal Farm', 1, 'Fiction', 1945, 'Available');

INSERT INTO members (full_name, email, phone, status) VALUES
  ('Amina Hassan', 'amina.hassan@example.com', '+15550001001', 'Active'),
  ('Ben Carter', 'ben.carter@example.com', '+15550001002', 'Active'),
  ('Clara Nguyen', 'clara.nguyen@example.com', '+15550001003', 'Suspended'),
  ('Diego Santos', 'diego.santos@example.com', '+15550001004', 'Inactive');

INSERT INTO loans (book_id, member_id, loaned_at, due_at, returned_at, fine_amount) VALUES
  (2, 1, CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE - INTERVAL '6 days', NULL, 0.00),
  (3, 2, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '4 days', NULL, 0.00),
  (4, 1, CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE - INTERVAL '16 days', CURRENT_DATE - INTERVAL '14 days', 2.00);

UPDATE books SET status = 'Borrowed' WHERE id IN (2, 3);
