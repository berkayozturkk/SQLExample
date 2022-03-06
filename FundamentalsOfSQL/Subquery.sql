--SUBQUERY                     

--�R�NLER�N F�YAT ANAL�Z�,EN �OK HANG� AY SATILDI

SELECT ITM.ITEMCODE AS URUNKODU,
       ITM.ITEMNAME AS URUNADI,
	  (SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ENDUSUKFIYAT,
	  (SELECT MAX(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ENYUKSAKFIYAT,
	  (SELECT AVG(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ORTALAMAFIYAT,
	  (SELECT SUM(AMOUNT)    FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAMADET ,
	  (
	  SELECT TOP 1 DATEPART(MONTH,O.DATE_) AS AY FROM ORDERDETAILS OD
	  INNER JOIN ORDERS O ON OD.ORDERID= O.ID
	  WHERE OD.ITEMID=ITM.ID
	  GROUP BY DATEPART(MONTH,O.DATE_) 
	  ORDER BY SUM(AMOUNT) DESC 
	  )   AS ENCOKSATILANAY
FROM ITEMS ITM 
--WHERE (SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) IS NULL
WHERE ITM.ID NOT IN (SELECT ITEMID FROM ORDERDETAILS)
ORDER BY 3

--KULLANICININ SON ADRES�N� BULMAK
SELECT U.* ,A.ADDRESSTEXT,A.ID
FROM USERS U
INNER JOIN ADDRESS A  ON U.ID=A.USERID

WHERE U.ID=1
ORDER BY A.ID DESC

---------
SELECT U.* , 
   (SELECT TOP 1 ADDRESSTEXT  FROM ADDRESS WHERE USERID=U.ID ORDER BY ID DESC)  SONADRES ,
   (SELECT TOP 1 ADDRESSTEXT  FROM ADDRESS WHERE USERID=U.ID ORDER BY ID     )  ILKADRES,
   (SELECT COUNT(ADDRESSTEXT) FROM ADDRESS WHERE USERID=U.ID)                   ADRESSAYISI
FROM USERS U





