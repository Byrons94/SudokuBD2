CREATE OR REPLACE FUNCTION GetValorEnFilaActual 
	(ppartida IN INTEGER, pfilaActual IN INTEGER, pcuadranteActual IN INTEGER, pvalor IN INTEGER) 
RETURN INTEGER AS
	resultado INTEGER := 0;
	BEGIN
		
		
		FOR posicion IN 
		(
			SELECT tpos.fila, tpos.columna 
			FROM posiciones tpos 
			WHERE tpos.fila = pfilaActual AND tpos.cuadrante <> pcuadranteActual
		)
		LOOP
		
			IF(GetValorPosicion(ppartida,posicion.fila,posicion.columna) = pvalor) THEN
				resultado := pvalor;
			END IF;
		
		END LOOP;
		
		
		RETURN resultado;
	END;
/