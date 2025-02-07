SHOW DATABASES;

Use AdventureWorksDW;

SELECT * FROM dimproduct; 

SELECT * FROM dimproductsubcategory;

-- 1.1 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
SELECT 
	p.ProductKey, 
    p.ProductAlternateKey, 
    p.ProductSubcategoryKey, 
    p.EnglishProductName, 
    p.ListPrice, 
    s.ProductSubcategoryKey, 
    s.EnglishProductSubcategoryName
FROM dimproduct as p
LEFT JOIN dimproductsubcategory as s
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey;


-- 1.2 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).
SELECT 
	p.ProductKey, 
    p.ProductAlternateKey, 
    p.ProductSubcategoryKey, 
    p.EnglishProductName, 
    p.ListPrice, 
    s.ProductSubcategoryKey, 
    s.EnglishProductSubcategoryName,
    c.ProductCategoryKey,
    c.EnglishProductCategoryName
FROM dimproduct as p
	JOIN dimproductsubcategory as s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
		JOIN dimproductcategory as c
		ON s.ProductCategoryKey = c.ProductCategoryKey;

-- 1.3 Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales). 
SELECT * FROM factresellersales;

SELECT
	p.ProductKey, 
    p.EnglishProductName, 
    sum(r.OrderQuantity) as TotalSold
FROM dimproduct as p
INNER JOIN factresellersales as r
ON p.ProductKey = r.ProductKey
Group BY p.ProductKey, p.EnglishProductName;

-- 1.4  Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
SELECT 
	ProductKey, ProductAlternateKey, EnglishProductName
    FROM dimproduct
    WHERE ProductKey NOT IN (SELECT ProductKey FROM factresellersales)
    AND
    FinishedGoodsFlag = 1;
    
-- 1.5 Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)
SELECT 
	r.SalesOrderNumber,
    r.SalesOrderLineNumber,
	r.OrderDate,
    r.DueDate,
    r.ShipDate,
	r.OrderQuantity,
    r.UnitPrice,
    r.TotalProductCost,
    r.SalesAmount,
    p.ProductKey,
	p.EnglishProductName
FROM factresellersales AS r
LEFT JOIN dimproduct AS p
ON r.ProductKey = p.ProductKey;

-- 2.1 Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT 
	r.SalesOrderNumber,
    r.SalesOrderLineNumber,
	r.OrderDate,
    r.DueDate,
    r.ShipDate,
	r.OrderQuantity,
    r.UnitPrice,
    r.TotalProductCost,
    r.SalesAmount,
    p.ProductKey,
	p.EnglishProductName,
    c.ProductCategoryKey,
    c.EnglishProductCategoryName,
    s.ProductSubcategoryKey
FROM factresellersales AS r
INNER JOIN dimproduct AS p
ON r.ProductKey = p.ProductKey
	INNER JOIN dimproductsubcategory as s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
		INNER JOIN dimproductcategory as c
		ON s.ProductCategoryKey = c.ProductCategoryKey;

-- 2.2 Esplora la tabella DimReseller.
SELECT * FROM dimreseller;
DESCRIBE dimreseller;
SHOW CREATE TABLE dimreseller;

-- 2.3 Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
SELECT * FROM dimgeography;

SELECT 
	x.ResellerName,
    x.GeographyKey,
    y.City,
    y.StateProvinceName,
    y.CountryRegionCode,
    y.EnglishCountryRegionName
FROM dimreseller AS x
INNER JOIN dimgeography AS y
ON x.GeographyKey = y.GeographyKey;

-- 2.4 Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
SELECT
	r.SalesOrderNumber, 
    r.SalesOrderLineNumber, 
    r.OrderDate, 
    r.UnitPrice, 
    r.OrderQuantity AS Quantity, 
    r.TotalProductCost,
    p.EnglishProductName,
    c.ProductCategoryKey,
    s.ProductSubcategoryKey,
    x.ResellerName,
	x.GeographyKey,
    y.City,
    y.StateProvinceName,
    y.CountryRegionCode,
    y.EnglishCountryRegionName
		FROM factresellersales AS r
        INNER JOIN dimproduct AS p
		ON r.ProductKey = p.ProductKey
			INNER JOIN dimproductsubcategory as s
			ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
				INNER JOIN dimproductcategory as c
				ON s.ProductCategoryKey = c.ProductCategoryKey
					INNER JOIN dimreseller AS x
                    ON r.ResellerKey = x.ResellerKey
						INNER JOIN dimgeography AS y
						ON x.GeographyKey = y.GeographyKey;
						