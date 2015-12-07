CREATE OR REPLACE PROCEDURE calcProbInic(ID_PARTIDA in NUMBER)AS

CURSOR INCOG is 
SELECT ti.id ID, tpos.fila FILA, tpos.columna COL, tpos.cuadrante CUAD
FROM incognitas ti 
JOIN posiciones tpos ON(ti.idposicion=tpos.id);



BEGIN



FOR incog_rec in INCOG
LOOP



	FOR pist_rec in (SELECT  LEVEL VAL
					FROM     dual
					CONNECT BY     LEVEL <= 9
					MINUS (SELECT  tpis.valor VAL
					from pistas tpis 
					JOIN posiciones tpos2 ON(tpis.idposicion=tpos2.id)
					WHERE tpos2.columna=incog_rec.COL 
					UNION SELECT tpis.valor VAL
					from pistas tpis 
					JOIN posiciones tpos2 ON(tpis.idposicion=tpos2.id)
					WHERE tpos2.fila=incog_rec.FILA
					UNION SELECT tpis.valor VAL
					from pistas tpis 
					JOIN posiciones tpos2 ON(tpis.idposicion=tpos2.id)
					WHERE tpos2.cuadrante=incog_rec.CUAD
					)) 
	LOOP

		INSERT INTO probabilidades (idjuego,idincognita,numero)
		VALUES(Probabilidades_seq.NEXTVAL,incog_rec.ID,pist_rec.VAL);

	END LOOP; 



END LOOP;

END;
/