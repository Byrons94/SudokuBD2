CREATE OR REPLACE FUNCTION UnicaOpcion (idIncognita IN INTEGER) 
RETURN BOOLEAN AS
	totalOpciones INTEGER := 0;
	BEGIN
		SELECT COUNT(1)
		INTO totalOpciones
		FROM incognitas ti
		INNER JOIN probabilidades tp ON tp.idIncognita = ti.id
		WHERE ti.id = idIncognita;
		
		IF totalOpciones = 1 THEN
			RETURN true;
		END IF;
		
		RETURN false;
	END;
/