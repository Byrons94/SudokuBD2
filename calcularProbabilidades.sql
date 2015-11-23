CREATE OR REPLACE PROCEDURE CalcularProbabilidades (pidPartida INTEGER) AS
	pistasXFila INTEGER := 0;
	pistasXColumna INTEGER := 0;
	pistasXCuadrante INTEGER := 0;
	BEGIN
		
		--por cada incognita
		FOR incognita IN (
			SELECT tinc.* 
			FROM incognitas tinc 
			WHERE tinc.idPartida = pidPartida AND tinc.valor IS NULL
		) LOOP
			
			--seleccionar total pistas x fila
			SELECT COUNT(1)
			INTO pistasXFila
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
			
			dbms_output.put_line('Incognita '||incognita.idPosicion||' por fila: '||pistasXFila);
			
			--si no hay 8 pistas
			IF pistasXFila < 8 THEN
			
				--seleccionar total pistas x columna
				SELECT COUNT(1)
				INTO pistasXColumna
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
					WHERE tpo.columna = 
					(
						SELECT tpos.columna
						FROM incognitas tinc 
						INNER JOIN posiciones tpos ON tpos.id = tinc.idPosicion
						WHERE tinc.idPosicion = incognita.idPosicion AND tinc.idPartida = incognita.idPartida
					)
				) AND casillas.valor IS NOT NULL;
				
				dbms_output.put_line('Incognita '||incognita.idPosicion||' por columna: '||pistasXColumna);
			
				--si no hay 8 pistas
				IF pistasXColumna < 8 THEN

					SELECT COUNT(1)
					INTO pistasXCuadrante
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
						WHERE tpo.cuadrante = 
						(
							SELECT tpos.cuadrante
							FROM incognitas tinc 
							INNER JOIN posiciones tpos ON tpos.id = tinc.idPosicion
							WHERE tinc.idPosicion = incognita.idPosicion AND tinc.idPartida = incognita.idPartida
						)
					) AND casillas.valor IS NOT NULL;
				
					
					
					dbms_output.put_line('Incognita '||incognita.idPosicion||' por cuadrante: '||pistasXCuadrante);
				
				END IF;
			
			END IF;
							
		END LOOP;		
		
	END;
/