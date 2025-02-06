USE product;
SELECT * FROM p1;

SELECT p1.Product , p1.CategoryID , p2.CategoryID , p2.Category FROM p1 CROSS JOIN p2;

SELECT p.ProductID , p.Product , c.Category, c.categoryid, p.CategoryID FROM p1 AS p INNER JOIN p2 AS C ON p.CategoryID = c.CategoryID;

SELECT P.ProductID , P.Product , C.Category , C.CategoryID , P.CategoryID FROM p1 AS P LEFT OUTER JOIN p2 AS C ON P.CategoryID = C.CategoryID;

SELECT ProductID, Product, ListPrice 
	FROM p1 WHERE ListPrice > (SELECT        
		AVG(ListPrice) 
			FROM p1);
