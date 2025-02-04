SHOW DATABASES;

Use AdventureWorksDW;

-- es. 2 Esplora la tabelle dei prodotti (DimProduct)
SELECT * FROM dimproduct;  

SELECT * FROM dimproduct WHERE ProductSubcategoryKey IS NOT NULL;  

-- es. 3 Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag FROM dimproduct;

-- es. 4 Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1
SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag FROM dimproduct 
	WHERE FinishedGoodsFlag = 1;
    
-- es. 5 Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello ProductAlternateKey) comincia con FR oppure BK. Il result set deve contenere il codice prodotto ProductKey), il modello, il nome del prodotto, il costo standard StandardCost) e il prezzo di listino ListPrice).
SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice FROM dimproduct 
	WHERE ProductAlternateKey LIKE 'FR%' OR 'BK%';
    
    -- 1. Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda ListPrice - StandardCost)
SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice, ListPrice - StandardCost AS Markup FROM dimproduct 
	WHERE ProductAlternateKey LIKE 'FR%' OR 'BK%';
    
  -- 2.  Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
SELECT ProductKey, EnglishProductName FROM dimproduct 
	WHERE FinishedGoodsFlag = 1 
    AND
    ListPrice between 1000 AND 2000;
    
    -- 3. Esplora la tabella degli impiegati aziendali DimEmployee)
SELECT * FROM dimemployee;

-- 4.Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
SELECT FirstName, LastName, MiddleName, NameStyle FROM dimemployee WHERE SalespersonFlag = '1';

-- 5. Interroga la tabella delle vendite FactResellerSales). Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto SalesAmount - TotalProductCost).
SELECT * FROM factresellersales;

SELECT * FROM factresellersales 
	WHERE ProductKey IN ('597', '598', '477', '214')
   AND
    OrderDate >= '2020-01-01';

SELECT SalesOrderNumber, SalesOrderLineNumber, SalesAmount - TotalProductCost AS Profitto FROM factresellersales
	WHERE ProductKey IN ('597', '598', '477', '214')
   AND
    OrderDate >= '2020-01-01';