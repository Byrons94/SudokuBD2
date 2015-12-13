CREATE OR REPLACE PROCEDURE ProbabilidadesColumna (pidPartida INTEGER, pincognita INTEGER, pcolumna INTEGER) AS
BEGIN
	FOR incognita IN (
		SELECT id, valor
		FROM (
			SELECT tin.id, tin.idPosicion, tin.valor
			FROM incognitas tin 
			INNER JOIN partidas tp ON tp.id = tin.idPartida
			INNER JOIN posiciones tpos ON tpos.id = tin.idPosicion
			WHERE tpos.columna = pcolumna AND tp.id = pidPartida AND tin.valor IS NOT NULL
		)
	) 
	LOOP
		DELETE FROM probabilidades tp
		WHERE (tp.numero = incognita.valor AND tp.idIncognita = pincognita);
	END LOOP;
END;
/