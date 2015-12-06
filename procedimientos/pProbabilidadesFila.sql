CREATE OR REPLACE PROCEDURE ProbabilidadesFila (pidPartida INTEGER,pidPosicion INTEGER) AS
BEGIN
	FOR incognita IN (
		SELECT casillas.id, casillas.valor
		FROM (
			SELECT tin.id, tin.idPosicion, tin.valor
			FROM incognitas tin 
			UNION
			SELECT 0, tpis.idPosicion, tpis.valor
			FROM pistas tpis
			INNER JOIN plantillas tplan ON tplan.id = tpis.idPlantilla
			INNER JOIN partidas tpart ON tpart.idPlantilla = tplan.id
			WHERE tpart.id = pidPartida
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
	END LOOP;
END;
/