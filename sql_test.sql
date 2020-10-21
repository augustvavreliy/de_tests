CREATE TABLE Users (
userId INT PRIMARY KEY,
age INT 
);

CREATE TABLE Items (
itemId INT PRIMARY KEY,
price DECIMAL(5,2)
);

CREATE TABLE Purchases (
purchaseId INT PRIMARY KEY, 
userId INT, 
itemId INT, 
date DATE,
FOREIGN KEY (userId) REFERENCES Users(userId),
FOREIGN KEY (itemId) REFERENCES Items(itemId)
);

INSERT INTO Users VALUES (1, 17);
INSERT INTO Users VALUES (2, 18);
INSERT INTO Users VALUES (3, 25);
INSERT INTO Users VALUES (4, 26);
INSERT INTO Users VALUES (5, 35);
INSERT INTO Users VALUES (6, 36);

INSERT INTO Items VALUES (1, 100);
INSERT INTO Items VALUES (2, 200);
INSERT INTO Items VALUES (3, 300);
INSERT INTO Items VALUES (4, 400);

INSERT INTO Purchases VALUES (1, 1, 1, '2020-10-10');
INSERT INTO Purchases VALUES (2, 2, 2, '2020-11-10');
INSERT INTO Purchases VALUES (3, 3, 3, '2020-09-10');
INSERT INTO Purchases VALUES (4, 4, 4, '2020-08-10');
INSERT INTO Purchases VALUES (5, 5, 1, '2020-10-10');
INSERT INTO Purchases VALUES (6, 6, 3, '2020-09-10');

-- Zadanie 1
SELECT AVG(i.price) FROM Purchases p 
JOIN Users u ON u.userId = p.userId
JOIN Items i ON i.itemId = p.itemId
WHERE u.age >= 18 AND u.age <= 25;

SELECT AVG(i.price) FROM Purchases p 
JOIN Users u ON u.userId = p.userId
JOIN Items i ON i.itemId = p.itemId
WHERE u.age >= 26 AND u.age <= 35;

--Zadanie 2
SELECT strftime('%m', p.date) FROM Purchases p 
JOIN Users u ON u.userId = p.userId
JOIN Items i ON i.itemId = p.itemId
WHERE u.age >= 35
GROUP BY strftime('%m', p.date)
ORDER BY SUM(i.price) DESC LIMIT 1;

--Zadanie 3
SELECT i.itemId FROM Purchases p 
JOIN Users u ON u.userId = p.userId
JOIN Items i ON i.itemId = p.itemId
GROUP BY i.itemId
ORDER BY SUM(i.price) DESC LIMIT 1;

--Zadanie 4
SELECT i.itemid,
      ROUND (SUM(i.price) * 1.0 / SUM(SUM(i.price)) OVER () , 2) as share
FROM Purchases p 
JOIN Items i ON i.itemid = p.itemId
WHERE p.date >= '2020-01-01' AND
      p.date < '2021-01-01'
GROUP BY i.itemid
ORDER BY SUM(i.price) DESC LIMIT 3;