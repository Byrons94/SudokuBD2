CREATE OR REPLACE FUNCTION GetValorPosicion (ppartida IN INTEGER, pfila IN INTEGER, pcolumna IN INTEGER) 
RETURN INTEGER AS
	resultado INTEGER := 0;
	BEGIN
		
		SELECT valor
		INTO resultado
		FROM
		(
			SELECT tpos.id, tpis.valor
			FROM partidas tpar
			INNER JOIN plantillas tplan ON tplan.id = tpar.idPlantilla
			INNER JOIN pistas tpis ON tpis.idPlantilla = tplan.id
			INNER JOIN posiciones tpos ON tpos.id = tpis.idPosicion
			WHERE tpos.fila = pfila AND tpos.columna = pcolumna
			UNION 
			SELECT tpos.id, tinc.valor
			FROM incognitas tinc 
			INNER JOIN posiciones tpos ON tpos.id = tinc.idPosicion
			WHERE tpos.fila = pfila AND tpos.columna = pcolumna
		)
		WHERE ROWNUM = 1;
		
		RETURN resultado;
	END;
/