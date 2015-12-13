CREATE OR REPLACE PROCEDURE ProbabilidadesAdyacentes (ppartida in INTEGER) IS

CURSOR INCOG IS 
SELECT ti.id ID, tposic.fila FILA, tposic.columna COL, tposic.cuadrante CUAD, ti.valor VAL
FROM incognitas ti 
JOIN posiciones tposic ON ti.idposicion=tposic.id
WHERE idPartida = ppartida AND ti.valor IS NULL;

BEGIN
			
	FOR incog_rec IN INCOG 
	LOOP
	
		--por cada resultado intersecado verticalmente		
		pProbAdyacentesVerticales(ppartida,incog_rec.id,incog_rec.FILA,incog_rec.COL,incog_rec.CUAD);
		
		--si hay mas de una opcion
		IF NOT UnicaOpcion(incog_rec.id) THEN
			--por cada resultado intersecado horizontalmente	
			pProbAdyacentesHorizontales(ppartida,incog_rec.id,incog_rec.FILA,incog_rec.COL,incog_rec.CUAD);
		END IF;
	END LOOP;
	
END;
/


