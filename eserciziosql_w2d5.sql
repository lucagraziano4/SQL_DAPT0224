/*Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).*/
SELECT A.*, B.EnglishProductSubcategoryName
FROM dimproduct A 
JOIN dimproductsubcategory B ON  A.ProductSubcategoryKey = B.ProductSubcategoryKey;

/*Esponi l’anagrafica dei prodotti indicando per ciascun prodotto 
la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).*/
SELECT A.*, B.EnglishProductSubcategoryName, C.EnglishProductCategoryName
FROM dimproduct A 
JOIN dimproductsubcategory B ON  A.ProductSubcategoryKey = B.ProductSubcategoryKey 
JOIN dimproductcategory C ON  B.ProductcategoryKey = C.ProductcategoryKey;

/*Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales)*/
SELECT DISTINCT A.ProductKey
FROM DimProduct A
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey
WHERE SalesAmount > 0;

/*Esponi l’elenco dei prodotti non venduti 
(considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)*/
SELECT *
FROM DimProduct A
WHERE A.ProductKey NOT IN 
(SELECT DISTINCT A.ProductKey
FROM DimProduct A
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey)
AND A.FinishedGoodsFlag = 1;

/* controprova se questa query: SELECT DISTINCT A.ProductKey
FROM DimProduct A
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey  diventa questa nuova query ----> SELECT DISTINCT A.ProductKey
FROM DimProduct A
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey
WHERE A.Productkey IN (210,211,226,227,228) e la sua tabella risultante e' vuota allora abbiamo svolto bene la subquery*/
SELECT DISTINCT A.ProductKey
FROM DimProduct A
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey
WHERE A.Productkey IN (210,211,226,227,228);

/*Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)*/
SELECT A.*, B.EnglishProductName
FROM FactResellerSales A 
JOIN DimProduct B ON A.ProductKey = B.ProductKey;
/*
SELECT A.EnglishProductName, B.*
FROM DimProduct A 
JOIN FactResellerSales B ON A.ProductKey = B.ProductKey;*/

/*Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.*/
SELECT A.*, D.EnglishProductCategoryName
FROM FactResellerSales A
JOIN DimProduct B ON A.ProductKey = B.ProductKey
JOIN DimProductSubcategory C ON B.ProductSubcategoryKey = C.ProductSubcategoryKey
JOIN DimProductCategory D ON C.ProductcategoryKey = D.ProductcategoryKey;

/*Esplora la tabella DimReseller.*/
SELECT *
FROM DimReseller;

/*Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica*/
SELECT A.GeographyKey, A.City, A.EnglishCountryRegionName, B.*
FROM dimgeography A
JOIN DimReseller B ON A.GeographyKey = B.GeographyKey;

/*Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi:
SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, 
il nome del reseller e l’area geografica.*/
SELECT C.SalesOrderNumber, C.SalesOrderLineNumber, C.OrderDate, 
C.UnitPrice, C.OrderQuantity, C.TotalProductCost,
D.EnglishProductName, F.EnglishProductCategoryName, 
B.ResellerName, A.GeographyKey, 
A.City, A.EnglishCountryRegionName
FROM dimgeography A
JOIN DimReseller B ON A.GeographyKey = B.GeographyKey
JOIN FactResellerSales C ON B.ResellerKey = C.ResellerKey
JOIN DimProduct D ON C.ProductKey = D.ProductKey
JOIN DimProductSubcategory E ON D.ProductSubcategoryKey = E.ProductSubcategoryKey
JOIN DimProductCategory F ON E.ProductcategoryKey = F.ProductcategoryKey;
