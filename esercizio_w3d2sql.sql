/*Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
Quali considerazioni/ragionamenti è necessario che tu faccia?*/
SELECT 
    COUNT(dimproduct.ProductKey) AS NumeroRighe,
    COUNT(DISTINCT dimproduct.ProductKey) AS NumeroRigheSenzaRipetizioni
FROM
    dimproduct;
    
/*Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.*/
SELECT 
    COUNT(CONCAT(FactResellerSales.SalesOrderNumber,
	FactResellerSales.SalesOrderLineNumber)) AS NUMERO_CHIAVE,
    COUNT(*)
FROM
    FactResellerSales;
	
/*Controprova: se il risultato di questa query e' nullo allora i valori sono PK*/
SELECT 
    SalesOrderLineNumber, SalesOrderNumber, COUNT(*)
FROM
    FactResellerSales
GROUP BY 1 , 2
HAVING COUNT(*) > 1;
/*Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/
SELECT OrderDate, COUNT(DISTINCT SalesOrderNumber) AS N_transizioni
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate;

/*Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.
I campi in output devono essere parlanti!*/
SELECT EnglishProductName AS nome_prodotto, 
SUM(SalesAmount) AS fatturato_totale,
SUM(OrderQuantity) AS quantita_totale, 
SUM(factresellersales.SalesAmount) / SUM(factresellersales.OrderQuantity) AS prezzo_medio
FROM FactResellerSales
JOIN DimProduct 
ON FactResellerSales.ProductKey = DimProduct.ProductKey
WHERE OrderDate >= '2020-01-01'
GROUP BY EnglishProductName;

/*Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) 
per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, 
il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!*/
SELECT SUM(A.SalesAmount) AS fatturato_totale,
SUM(A.OrderQuantity) AS quantita_totale,
D.EnglishProductCategoryName AS nome_categoriaprodotto
FROM FactResellerSales A
JOIN DimProduct B ON A.ProductKey = B.ProductKey
JOIN DimProductSubcategory C ON B.ProductSubcategoryKey = C.ProductSubcategoryKey
JOIN DimProductCategory D ON C.ProductCategoryKey = D.ProductCategoryKey
GROUP BY EnglishProductCategoryName;

/*Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.*/
SELECT SUM(C.SalesAmount) AS fatturato_totale,
A.City
FROM DimGeography A
JOIN DimReseller B ON A.GeographyKey = B.GeographyKey
JOIN FactResellerSales C ON B.ResellerKey = C.ResellerKey
WHERE C.OrderDate >= '2020-01-01' 
GROUP BY A.City
HAVING SUM(C.SalesAmount) > 60000;