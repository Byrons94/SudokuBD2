CREATE OR REPLACE PROCEDURE ProbabilidadesFila (pidPartida INTEGER,pidPosicion INTEGER) AS
BEGIN
	FOR incognita IN (
		SELECT casillas.id, casillas.valor
		FROM (
			SELECT tin.id, tin.idPosicion, tin.valor
			FROM incognitas tin 
			INNER JOIN partidas tp ON tp.id = tin.idPartida
			WHERE tp.id = pidPartida
		) casillas
		WHERE casillas.idPosicion IN
		(
			SELECT tpo.id 
			FROM posiciones tpo 
			WHERE tpo.fila = 
			(
				SELECT tpos.fila
				FROM incognitas tinc 
				INNER JOIN posiciones tpos ON tpos.id = tinc.idPosicion
				WHERE tinc.idPosicion = pidPosicion AND tinc.idPartida = pidPartida
			)
		) AND casillas.valor IS NOT NULL
	) 
	LOOP
		DELETE FROM probabilidades tp
		WHERE (tp.numero = incognita.valor AND tp.idIncognita = incognita.id);
		--dbms_output.put_line('Incognita:'||incognita.id||' | valor:'||incognita.valor);
	END LOOP;
END;
/