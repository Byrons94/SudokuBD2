CREATE OR REPLACE PROCEDURE llenaIncognitas(idpartida NUMBER) AS



cursor c1 is
     SELECT id POS FROM POSICIONES MINUS SELECT IDPOSICION  FROM PISTAS;


BEGIN


FOR POSICIONES_REC in c1
LOOP

INSERT INTO INCOGNITAS(ID,IDPOSICION,IDPARTIDA,NUMINTENTO,VALOR)
VALUES (Incognitas_seq.NEXTVAL, POSICIONES_REC.POS, idpartida, NULL, NULL); 
END LOOP;



END;
/