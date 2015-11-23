CREATE OR REPLACE PROCEDURE CalcularProbabilidades (pidPartida INTEGER) AS
	totalPistas INTEGER := 0;
	BEGIN
		
		--por cada incognita
		FOR incognita IN (
			SELECT tinc.* 
			FROM incognitas tinc 
			WHERE tinc.idPartida = pidPartida AND tinc.valor IS NULL
		) LOOP
			
			--seleccionar total incognitas x fila
			SELECT COUNT(1)
			INTO totalPistas
			FROM (
				SELECT tin.idPosicion, tin.valor
				FROM incognitas tin 
				UNION
				SELECT tpis.idPosicion, tpis.valor
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
					WHERE tinc.idPosicion = incognita.idPosicion AND tinc.idPartida = incognita.idPartida
				)
			) AND casillas.valor IS NOT NULL;
			
			--dbms_output.put_line('Incognita '||incognita.idPosicion||': '||totalPistas);
			
							
		END LOOP;		
		
	END;
/