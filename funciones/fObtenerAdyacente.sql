CREATE OR REPLACE FUNCTION ObtenerAdyacente (pnumero IN INTEGER, pesPrimero IN NUMBER) 
RETURN INTEGER AS
	numAux INTEGER := 0;
	BEGIN
		
		--si es 3,6,9
		IF MOD(pnumero,3) = 0 THEN 
			IF pesPrimero = 1 THEN
				RETURN pnumero - 2;
			ELSE
				RETURN pnumero - 1;
			END IF;
		ELSE
			numAux := pnumero + 1;
			
			--si es 2,5,8
			IF MOD(numAux,3) = 0 THEN 
				IF pesPrimero = 1 THEN
					RETURN pnumero - 1;
				ELSE
					RETURN pnumero + 1;
				END IF;
			ELSE
				--si es 1,4,7
				
				IF pesPrimero = 1 THEN
					RETURN pnumero + 1;
				ELSE
					RETURN pnumero + 2;
				END IF;
			END IF;
		END IF;
		
	END;
/