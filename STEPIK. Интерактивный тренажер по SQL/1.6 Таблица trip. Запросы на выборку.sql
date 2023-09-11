-- use stepik

/* Структура и наполнение таблицы
Таблица trip, в которой представлена информация о командировках сотрудников некоторой организации 
(фамилия сотрудника, город, куда он ездил, размер суточных, даты первого и последнего дня командировки): */  
CREATE TABLE trip(
	   trip_id INT PRIMARY KEY AUTO_INCREMENT, 
	   name VARCHAR(30), 
	   city VARCHAR(25), 
	   per_diem DECIMAL(8, 2), 
	   date_first DATE, 
	   date_last DATE);

INSERT INTO trip(name, city, per_diem, date_first, date_last)
VALUES 
	('Баранов П.Е.', 'Москва', 700, '2020-01-12', '2020-01-17'),
	('Абрамова К.А.', 'Владивосток', 450, '2020-01-14', '2020-01-27'),
	('Семенов И.В.', 'Москва', 700, '2020-01-23', '2020-01-31'),
	('Ильиных Г.Р.', 'Владивосток', 450, '2020-01-12', '2020-02-02'),
	('Колесов С.П.', 'Москва', 700, '2020-02-01', '2020-02-06'),
	('Баранов П.Е.', 'Москва', 700, '2020-02-14', '2020-02-22'),
	('Абрамова К.А.', 'Москва', 700, '2020-02-23', '2020-03-01'),
	('Лебедев Т.К.', 'Москва', 700, '2020-03-03', '2020-03-06'),
	('Колесов С.П.', 'Новосибирск', 450, '2020-02-27', '2020-03-12'),
	('Семенов И.В.', 'Санкт-Петербург', 700, '2020-03-29', '2020-04-05'),
	('Абрамова К.А.', 'Москва', 700, '2020-04-06', '2020-04-14'),
	('Баранов П.Е.', 'Новосибирск', 450, '2020-04-18', '2020-05-04'),
	('Лебедев Т.К.', 'Томск', 450, '2020-05-20', '2020-05-31'),
	('Семенов И.В.', 'Санкт-Петербург', 700, '2020-06-01', '2020-06-03'),
	('Абрамова К.А.', 'Санкт-Петербург', 700, '2020-05-28', '2020-06-04'),
	('Федорова А.Ю.', 'Новосибирск', 450, '2020-05-25', '2020-06-04'),
	('Колесов С.П.', 'Новосибирск', 450, '2020-06-03', '2020-06-12'),
	('Федорова А.Ю.', 'Томск', 450, '2020-06-20', '2020-06-26'),
	('Абрамова К.А.', 'Владивосток', 450, '2020-07-02', '2020-07-13'),
	('Баранов П.Е.', 'Воронеж', 450, '2020-07-19', '2020-07-25');

SELECT * FROM trip;

/* Задание 1
Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», 
в отсортированном по убыванию даты последнего дня командировки виде. 
В результат включить столбцы name, city, per_diem, date_first, date_last. */
SELECT name, city, per_diem, date_first, date_last
  FROM trip
 WHERE name LIKE "%а %"
 ORDER BY date_last DESC;
 
/* Задание 2
Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве. */
SELECT DISTINCT name
  FROM trip
 WHERE city = "Москва"
 ORDER BY name;
 
/* Задание 3
Для каждого города посчитать, сколько раз сотрудники в нем были.  Информацию вывести в отсортированном 
в алфавитном порядке по названию городов. Вычисляемый столбец назвать Количество. */
SELECT city, COUNT(city) AS "Количество"
  FROM trip
 GROUP BY city
 ORDER BY city;

/* Задание 4
Вывести два города, в которых чаще всего были в командировках сотрудники. 
Вычисляемый столбец назвать Количество. */
SELECT city, COUNT(city) AS "Количество"
  FROM trip
 GROUP BY city
 ORDER BY Количество DESC
 LIMIT 2;
 
/* Задание 5
Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, 
город ,  длительность командировки в днях, при этом первый и последний день относится к периоду командировки).  
Последний столбец назвать Длительность. Информацию вывести в упорядоченном по убыванию длительности поездки, а потом 
по убыванию названий городов (в обратном алфавитном порядке). */
SELECT name, city, 
       DATEDIFF(date_last, date_first) + 1 AS "Длительность"
  FROM trip
 WHERE city NOT IN ("Москва", "Санкт-Петербург")
 ORDER BY Длительность DESC, city DESC;

/* Задание 6
Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name, city, date_first, date_last. */
SELECT name, city, date_first, date_last
  FROM trip
 WHERE DATEDIFF(date_last, date_first) = (
       SELECT MIN(DATEDIFF(date_last, date_first))
         FROM trip);

/* Задание 7
Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой). 
В результат включить столбцы name, city, date_first, date_last. Строки отсортировать сначала  в алфавитном 
порядке по названию города, а затем по фамилии сотрудника. */
SELECT name, city, date_first, date_last
  FROM trip
 WHERE MONTH(date_first) = MONTH(date_last)
 ORDER BY city, name;

/* Задание 8
Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к 
некоторому месяцу, если она началась в этом месяце. Информацию вывести сначала в отсортированном по убыванию 
количества, а потом в алфавитном порядке по названию месяца виде. Название столбцов – Месяц и Количество. */
SELECT MONTHNAME(date_first) AS "Месяц", 
       COUNT(MONTHNAME(date_first)) AS "Количество"
  FROM trip
 GROUP BY MONTHNAME(date_first)
 ORDER BY Количество DESC, Месяц;
 
/* Задание 9
Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, 
первый день которых пришелся на февраль или март 2020 года. Значение суточных для каждой командировки 
занесено в столбец per_diem. Вывести фамилию и инициалы сотрудника, город, первый день командировки и сумму 
суточных. Последний столбец назвать Сумма. Информацию отсортировать сначала  в алфавитном порядке по фамилиям 
сотрудников, а затем по убыванию суммы суточных. */
SELECT name, city, date_first, 
       (DATEDIFF(date_last, date_first) +1 ) * per_diem AS "Сумма"
  FROM trip
 WHERE (MONTH(date_first) IN (2, 3)) AND (YEAR(date_first) = 2020)
 ORDER BY name, Сумма DESC;

/* Задание 10 */
-- Только для этого задания изменена строка таблицы trip: */ 
UPDATE trip SET date_last = '2020-03-02' WHERE trip_id = 4;

/* Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, 
которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. 
Последний столбец назвать Сумма. */
SELECT name, 
       SUM((DATEDIFF(date_last, date_first) + 1) * per_diem) AS "Сумма"
  FROM trip
 WHERE name IN (
       SELECT name
         FROM trip
        GROUP BY name
       HAVING COUNT(name) > 3)
 GROUP BY name
 ORDER BY Сумма DESC;
 
 -- Возвращение таблицы к исходному состоянию
 UPDATE trip SET date_last = '2020-02-02' WHERE trip_id = 4;
 SELECT * FROM trip;
 