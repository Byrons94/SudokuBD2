Declare
filaJ      number(2) := 1;
columnaJ   number(2) := 1;
cuadranteJ number(2) := 1;
contador   number(10);
val        number(3);

Begin

	FOR contador in 1..81 LOOP

cuadranteJ := CASE 
 				WHEN columnaJ <= 3
 			     THEN CASE  
 			     			WHEN filaJ <= 3 
 			     				THEN 1
 			     			WHEN filaJ <= 6 
 			     				THEN 4
 			     			WHEN filaJ <= 9 
 			     				THEN 7	
 			     			END
 			    WHEN columnaJ <= 6
 			     THEN CASE 
 			     			WHEN filaJ <= 3 
 			     				THEN 2
 			     			WHEN filaJ <= 6 
 			     				THEN 5
 			     			WHEN filaJ <= 9 
 			     				THEN 8	
 			     			END
 			    WHEN columnaJ <= 9
 			      THEN CASE 
 			     			WHEN filaJ <= 3 
 			     				THEN 3
 			     			WHEN filaJ <= 6 
 			     				THEN 6
 			     			WHEN filaJ <= 9 
 			     				THEN 9	
 			     			END 
 			     END;

 	INSERT INTO POSICIONES
			(ID, FILA, COLUMNA, CUADRANTE)
		VALUES
			(contador, filaJ, columnaJ, cuadranteJ);
		      
		IF columnaJ = 9 then 
			columnaJ := 1;
		ELSE 	
			columnaJ   := columnaJ + 1;
		END IF;

		IF MOD(contador, 9) = 0 THEN 
			filaJ := filaJ+1;
		END IF;

	END LOOP;

End;
/