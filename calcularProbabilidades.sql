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
				)
			) AND casillas.valor IS NOT NULL;
			
				
			END LOOP;
			
			
		END LOOP;
		
		
	END;
/