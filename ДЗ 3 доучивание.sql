--Задача 1. Уникальные названия маршрутов (destination.name), для которых существуют билеты (есть запись в tickets). Вывести только названия.
SELECT DISTINCT destination.name
FROM tickets
JOIN destination ON destination.id = tickets.id_destination

--Задача 1. Дополните предыдущий запрос: ограничьте маршруты статусом «Без визы».1 вар
SELECT DISTINCT destination.name
FROM tickets
JOIN destination ON destination.id = tickets.id_destination
JOIN status ON status.id = destination.id_status
WHERE status."name"='без визы'

--Задача 1. Дополните предыдущий запрос: ограничьте маршруты статусом «Без визы». 2 вар
SELECT DISTINCT destination.name
FROM tickets
JOIN destination ON destination.id = tickets.id_destination
WHERE destination.id_status = (SELECT id FROM status WHERE name = 'без визы')

--Задача 1 Найдите маршруты, максимальная цена которых выше общей средней. 
--Общая средняя находится как среднее значение lowest_price и highest_price. Вывести названия и высшую цену.
SELECT dectination.name AS destination_name, tickets.highest_price
FROM tickets
JOIN destination ON tickets.id_destination = destination.id
WHERE tickets.highest_price > (SELECT AVG(lowest_price + highest)/2 FROM tickets)

--Задача2 Список уникальных классов. Вывести только названия.
SELECT DISTINCT class_name FROM visits

--Задача 2 Количество часов, проведенных на занятиях, для каждого пользователя. Вывести фамилию, имя и количество часов.
SELECT 
users.user_surname, users.user_name, SUM(hours_spent) AS total hours
FROM visits JOIN users ON users.id_user = visits.id_user
GROUP BY users.user_surname, users.user_name;

--Задача 2. Средний возраст пользователей, посещающих класс Flex.
SELECT AVG(users.age) AS avg_age
FROM visits JOIN users ON users.id_user = visits.id_user
WHERE class_name = 'Flex';

-- Задача 3 Уникальные названия всех книг, опубликованных после 1990 года. Вывести только названия.
SELECT DISTINCT title
FROM book
WHERE year_publish>='1991-01-01';
-- 2 вар
SELECT DISTINCT title
FROM book
WHERE to_char(year_publish,'YYYY')>'1990';

--Задача 3. Для каждого автора найти сумму напечатанных страниц. Вывести полное имя автора и сумму страниц.
SELECT author.full_name, SUM(book.pages) AS total_pages
FROM book JOIN author ON author.id_author = book.id_author
GROUP BY author.full_name;

--Задача 3.Подсчитать количество книг авторов каждого века. Вывести век и количество книг.
SELECT author.century, COUNT(book.id_book) AS book_count
FROM author
JOIN book ON author.id_author = book.id_author
GROUP BY author.century;