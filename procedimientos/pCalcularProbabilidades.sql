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
			ProbabilidadesFila(incognita.id,incognita.idPosicion);			
			--dbms_output.put_line('Incognita '||incognita.idPosicion||' por fila: '||pistasXFila);
			/*
			--si hay mas de una opcion
			IF NOT UnicaOpcion(incognita.id) THEN
			
				--seleccionar total pistas x columna
				ProbabilidadesColumna(incognita.id,incognita.valor);			
				dbms_output.put_line('Incognita '||incognita.idPosicion||' por columna: '||pistasXColumna);
			
				--si hay mas de una opcion
				IF NOT UnicaOpcion(incognita.id) THEN

					--seleccionar total pistas x cuadrante
					ProbabilidadesCuadrante(incognita.id,incognita.valor);			
					dbms_output.put_line('Incognita '||incognita.idPosicion||' por cuadrante: '||pistasXCuadrante);
				
				END IF;
			
			END IF;
					*/		
		END LOOP;		
		
	END;
/