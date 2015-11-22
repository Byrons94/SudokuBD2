Declare
filaJ      number(2) := 1;
columnaJ   number(2) := 0;
cuadranteJ number(2);
Begin

	FOR cuadranteJ in 1..81 LOOP
		columnaJ := columnaJ+1;
		
		IF columnaJ = 10 then 
			columnaJ := 1;
		END IF;
		
		INSERT INTO POSICIONES
			(ID, FILA, COLUMNA, CUADRANTE)
		VALUES
			(cuadranteJ, filaJ, columnaJ, cuadranteJ); 

		IF MOD(cuadranteJ, 9) = 0 THEN 
			filaJ := filaJ+1;
		END IF;
		
		
	END LOOP;

End;
/