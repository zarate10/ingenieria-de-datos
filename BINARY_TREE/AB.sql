-- N valor del nodo, P padre de N

CREATE DATABASE AB
GO
USE AB 
GO
CREATE TABLE BST (
    n INT, 
    p INT
)
GO 
INSERT INTO BST VALUES 
    (1, 2),
    (3, 2),
    (6, 8),
    (9, 8),
    (2, 5),
    (8, 5),
    (5, NULL);
GO 
SELECT 
	n,
	CASE 
		WHEN p IS NULL THEN 'Root'
		WHEN n IN(SELECT p FROM BST) THEN 'Inner'
		ELSE 'Leaf'
	END
FROM BST
ORDER BY n ASC; 