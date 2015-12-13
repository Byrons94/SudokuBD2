CREATE OR REPLACE PROCEDURE CalcularProbabilidades (pidPartida INTEGER) AS
	pistasXFila INTEGER := 0;
	pistasXColumna INTEGER := 0;
	pistasXCuadrante INTEGER := 0;
	BEGIN
		
		--por cada incognita
		FOR incognita IN (
			SELECT tinc.id, tinc.valor, tp.fila, tp.columna, tp.cuadrante 
			FROM incognitas tinc 
			INNER JOIN posiciones tp ON tp.id = tinc.idPosicion
			WHERE tinc.idPartida = pidPartida AND tinc.valor IS NULL
		) LOOP
			
			--seleccionar total pistas x fila
			ProbabilidadesFila(pidPartida,incognita.id,incognita.fila);			
			
			--si hay mas de una opcion
			IF NOT UnicaOpcion(incognita.id) THEN
			
				--seleccionar total pistas x columna
				ProbabilidadesColumna(pidPartida,incognita.id,incognita.columna);			
			
				--si hay mas de una opcion
				IF NOT UnicaOpcion(incognita.id) THEN

					--seleccionar total pistas x cuadrante
					ProbabilidadesCuadrante(pidPartida,incognita.id,incognita.cuadrante);			
					
					--si hay mas de una opcion
					IF NOT UnicaOpcion(incognita.id) THEN

						--seleccionar total pistas x cuadrante
						ProbabilidadesAdyacentes(pidPartida);			
					
					END IF;
				
				END IF;
			
			END IF;
							
		END LOOP;		
		
	END;
/