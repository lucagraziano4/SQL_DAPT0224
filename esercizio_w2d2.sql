/*Esplora la tabelle dei prodotti (DimProduct)*/
SELECT *
FROM adv.dimproduct;

/*Interroga la tabella dei prodotti (DimProduct) 
ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.*/
SELECT adv.dimproduct.productkey AS codprodotto,
adv.dimproduct.ProductAlternateKey AS codmodello,
adv.dimproduct.EnglishProductName AS nomeinglese,
adv.dimproduct.Color AS colore,
adv.dimproduct.StandardCost AS costostandard,
adv.dimproduct.FinishedGoodsFlag AS finito
FROM adv.dimproduct;

/*Partendo dalla query scritta nel passaggio precedente, 
esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.*/
SELECT adv.dimproduct.productkey AS codprodotto,
adv.dimproduct.ProductAlternateKey AS codmodello,
adv.dimproduct.EnglishProductName AS nomeinglese,
adv.dimproduct.Color AS colore,
adv.dimproduct.StandardCost AS costostandard,
adv.dimproduct.FinishedGoodsFlag AS finito
FROM adv.dimproduct
WHERE adv.dimproduct.FinishedGoodsFlag = 1;

/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
Il result set deve contenere il codice prodotto (ProductKey), 
il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).*/
SELECT 
adv.dimproduct.productkey AS codprodotto,
adv.dimproduct.ProductAlternateKey AS codmodello,
adv.dimproduct.ModelName AS modello,
adv.dimproduct.EnglishProductName AS nomeinglese,
adv.dimproduct.StandardCost AS costostandard,
adv.dimproduct.ListPrice AS prezzolistino
FROM adv.dimproduct
WHERE adv.dimproduct.ProductAlternateKey LIKE 'FR%' 
OR adv.dimproduct.ProductAlternateKey LIKE 'BK%';

/*Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)*/
SELECT 
adv.dimproduct.productkey AS codprodotto,
adv.dimproduct.ProductAlternateKey AS codmodello,
adv.dimproduct.EnglishProductName AS nomeinglese,
adv.dimproduct.StandardCost AS costostandard,
adv.dimproduct.ListPrice AS prezzolistino,
adv.dimproduct.ListPrice - adv.dimproduct.StandardCost AS Markup
FROM adv.dimproduct
WHERE adv.dimproduct.ProductAlternateKey LIKE 'FR%' 
OR adv.dimproduct.ProductAlternateKey LIKE 'BK%';

/*Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.*/
SELECT 
adv.dimproduct.ProductKey AS codprodotto,
adv.dimproduct.ProductAlternateKey AS codmodello,
adv.dimproduct.ModelName AS modello,
adv.dimproduct.ListPrice AS prezzolistino,
adv.dimproduct.FinishedGoodsFlag AS finito
FROM adv.dimproduct
WHERE adv.dimproduct.ListPrice >= 1000 AND adv.dimproduct.FinishedGoodsFlag <= 2000;

/*Esplora la tabella degli impiegati aziendali (DimEmployee)*/
SELECT *
FROM DimEmployee;

/*Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. 
Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.*/
SELECT *
FROM DimEmployee
WHERE SalespersonFlag = 1;

/*Interroga la tabella delle vendite (FactResellerSales). 
Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. 
Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/
SELECT * 
FROM FactResellerSales
WHERE ProductKey IN (597,598,477,214) AND OrderDate BETWEEN '2020/01/01' AND '2024/05/08'