CREATE OR REPLACE FUNCTION GetValorEnColumnaActual 
	(ppartida IN INTEGER, pcolumnaActual IN INTEGER, pcuadranteActual IN INTEGER, pvalor IN INTEGER) 
RETURN INTEGER AS
	resultado INTEGER := 0;
	BEGIN
		
		
		FOR posicion IN 
		(
			SELECT tpos.fila, tpos.columna 
			FROM posiciones tpos 
			WHERE tpos.columna = pcolumnaActual AND tpos.cuadrante <> pcuadranteActual
		)
		LOOP
		
			IF(GetValorPosicion(ppartida,posicion.fila,posicion.columna) = pvalor) THEN
				resultado := pvalor;
			END IF;
		
		END LOOP;
		
		
		RETURN resultado;
	END;
/