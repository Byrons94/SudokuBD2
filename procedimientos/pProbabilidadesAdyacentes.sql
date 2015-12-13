CREATE OR REPLACE PROCEDURE ProbabilidadesAdyacentes 
	(ppartida IN INTEGER, pincognita IN INTEGER, pfila IN INTEGER, pcolumna IN INTEGER, pcuadrante IN INTEGER) IS
/*
CURSOR INCOG IS 
SELECT ti.id ID, tposic.fila FILA, tposic.columna COL, tposic.cuadrante CUAD, ti.valor VAL
FROM incognitas ti 
JOIN posiciones tposic ON ti.idposicion=tposic.id
WHERE idPartida = ppartida AND ti.valor IS NULL;
*/
BEGIN
			
	/*FOR incog_rec IN INCOG 
	LOOP*/
	
		--por cada resultado intersecado verticalmente		
		pProbAdyacentesVerticales(ppartida,pincognita,pfila,pcolumna,pcuadrante);
		
		--si hay mas de una opcion
		IF NOT UnicaOpcion(pincognita) THEN
			--por cada resultado intersecado horizontalmente	
			pProbAdyacentesHorizontales(ppartida,pincognita,pfila,pcolumna,pcuadrante);
		END IF;
	--END LOOP;
	
END;
/


