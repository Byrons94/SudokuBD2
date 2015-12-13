CREATE OR REPLACE PROCEDURE ProbabilidadesFila (pidPartida INTEGER, pincognita INTEGER, pfila INTEGER) AS
BEGIN
	FOR incognita IN (
		SELECT id, valor
		FROM (
			SELECT tin.id, tin.idPosicion, tin.valor
			FROM incognitas tin 
			INNER JOIN partidas tp ON tp.id = tin.idPartida
			INNER JOIN posiciones tpos ON tpos.id = tin.idPosicion
			WHERE tpos.fila = pfila AND tp.id = pidPartida AND tin.valor IS NOT NULL
		)		
	) 
	LOOP
		DELETE FROM probabilidades tp
		WHERE (tp.numero = incognita.valor AND tp.idIncognita = pincognita);
		--dbms_output.put_line('Incognita:'||incognita.id||' | valor:'||incognita.valor);
	END LOOP;
END;
/