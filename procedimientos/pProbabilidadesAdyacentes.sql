CREATE OR REPLACE PROCEDURE ProbabilidadesAdyacentes (ID_PARTIDA in NUMBER) IS

CURSOR INCOG IS 
SELECT ti.id ID, tpos.fila FILA, tpos.columna COL, tpos.cuadrante CUAD
FROM incognitas ti 
JOIN posiciones tpos ON(ti.idposicion=tpos.id)
WHERE idPartida = ID_PARTIDA;

A number :=0;
B number:= 0;

BEGIN
	FOR incog_rec IN INCOG 
	LOOP

		IF(incog_rec.FILA >1 AND incog_rec.COL >1) AND (incog_rec.FILA <9 AND incog_rec.COL <9) THEN

			SELECT tpis.valor INTO A
					FROM partidas tpar 
					INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
					INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
					INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
					WHERE tpar.id = ID_PARTIDA AND (tpos.fila = incog_rec.FILA+1)
			INTERSECT 
			SELECT tpis.valor 
					FROM partidas tpar 
					INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
					INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
					INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
					WHERE tpar.id = ID_PARTIDA AND (tpos.fila = incog_rec.FILA-1);		

		END IF;

	END LOOP;
	
END;
/


