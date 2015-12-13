CREATE OR REPLACE PROCEDURE PintarCuadrante (ppartida IN INTEGER, pCuadrante IN INTEGER) AS
	linea VARCHAR(500) := '';
	valor INTEGER := 0;
	contador INTEGER := 1;
	BEGIN
		
		FOR posicion IN 
		(
			SELECT tpos.fila, tpos.columna 
			FROM posiciones tpos 
			WHERE tpos.cuadrante = pCuadrante
		)
		LOOP
			valor := GetValorPosicion(ppartida,posicion.fila,posicion.columna);
			
			IF valor IS NULL THEN
				valor := 0;
			END IF;
			
			linea := linea || valor || ' | ';
			IF(MOD(contador,3) = 0) THEN
				dbms_output.put_line(linea);
				linea := '';
			END IF;
			contador := contador+1;
		END LOOP;
		
	END;
/