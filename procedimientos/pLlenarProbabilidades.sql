CREATE OR REPLACE PROCEDURE LlenarProbabilidades(ID_PARTIDA in NUMBER)AS

CURSOR INCOG is 
SELECT ti.id ID, tpos.fila FILA, tpos.columna COL, tpos.cuadrante CUAD
FROM incognitas ti 
JOIN posiciones tpos ON(ti.idposicion=tpos.id)
WHERE idPartida = ID_PARTIDA;

BEGIN
	FOR incog_rec IN INCOG
	LOOP
		FOR pist_rec IN 
		(
			SELECT LEVEL VAL
			FROM dual
			CONNECT BY LEVEL <= 9
			MINUS 
			(
				SELECT tpis.valor 
				FROM partidas tpar 
				INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
				INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
				INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
				WHERE tpos.columna = incog_rec.COL AND tpar.id = ID_PARTIDA
				UNION 
				SELECT tpis.valor 
				FROM partidas tpar 
				INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
				INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
				INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
				WHERE tpos.fila = incog_rec.FILA AND tpar.id = ID_PARTIDA
				UNION 
				SELECT tpis.valor 
				FROM partidas tpar 
				INNER JOIN plantillas tpla ON tpla.id = tpar.idPlantilla 
				INNER JOIN pistas tpis ON tpis.idPlantilla = tpla.id 
				INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
				WHERE tpos.cuadrante = incog_rec.CUAD AND tpar.id = ID_PARTIDA
			)
		) 
		LOOP
			INSERT INTO probabilidades (idjuego,idincognita,numero)
			VALUES(Probabilidades_seq.NEXTVAL,incog_rec.ID,pist_rec.VAL);
		END LOOP; 
	END LOOP;
END;
/